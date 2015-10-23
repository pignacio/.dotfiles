#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import (absolute_import, unicode_literals, division,
                        print_function)

import argparse
import collections
import json
import logging
import os
import re
import subprocess
import sys
import time

import pyinotify

logger = logging.getLogger(__name__)  # pylint: disable=invalid-name

HostPort = collections.namedtuple('HostPort', ['host', 'port'])

_DEFAULT_RUNSERVER_PORT = 8000


def _parse_hostport(text):
    if ":" in text:
        host, port = text.split(":", 1)
    else:
        host, port = None, text

    try:
        port = int(port)
    except (ValueError, TypeError):
        raise ValueError("Port is not an int: '{}'  (from:{})".format(port,
                                                                      text))
    return HostPort(host, port)


def _hostport_to_arg(hostport):
    if hostport.host:
        port = hostport.port or _DEFAULT_RUNSERVER_PORT
        return "{}:{:d}".format(hostport.host, port)
    elif hostport.port:
        return str(hostport.port)
    else:
        return None


def _get_argument_parser():
    parser = argparse.ArgumentParser()
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "hostport",
        type=_parse_hostport,
        default=HostPort(None, None),
        nargs="?",
        help="host and port, in [host:]port format. Overrides config port")
    parser.add_argument(
        "--open",
        action='store_true',
        default=False,
        help=("Runs the server open to the world. "
              "Overrides the host part of the [HOSTPORT] argument."))
    parser.add_argument(
        "runserver_args",
        nargs="*",
        help="Extra arguments for the manage.py runserver command.")
    return parser


def _get_manage_py():
    directory = os.path.abspath(os.path.curdir)
    while directory:
        manage_py = os.path.join(directory, 'manage.py')
        if os.path.isfile(manage_py):
            return manage_py
        if os.path.exists(os.path.join(directory, '.git')):
            print("Found git directory in {}".format(directory))
            break
        directory = os.path.dirname(directory)
    raise ValueError('manage.py not found')


def _read_config(config_file):
    with open(config_file) as config_fp:
        return json.load(config_fp)


class EventHandler(pyinotify.ProcessEvent):
    def __init__(self, *args, **kwargs):
        super(EventHandler, self).__init__(*args, **kwargs)
        self.touched = False

    def process_default(self, *args, **kwargs):
        self.touched = True


def _get_staticfiles_notifier(handler):
    manager = pyinotify.WatchManager()
    mask = pyinotify.IN_MODIFY | pyinotify.IN_CREATE | pyinotify.IN_DELETE

    proc = subprocess.Popen(['python', '-c', (
        'from django.conf import settings\n'
        'for dirname in settings.STATICFILES_DIRS: print dirname')],
                            stdout=subprocess.PIPE)

    for line in proc.stdout:
        if line.strip():
            logger.info("Watching '%s'", line.strip())
            manager.add_watch(line.strip(), mask, rec=True)

    return pyinotify.Notifier(manager, handler, timeout=1)


def _get_all_pids(pid):
    proc = subprocess.Popen(['pstree', str(pid), '-p'], stdout=subprocess.PIPE)
    pids = re.findall(r'\(\d+\)', proc.stdout.read())
    return [p.strip("()") for p in pids]


def _poll_notifier(notifier):
    notifier.process_events()
    while notifier.check_events():
        notifier.read_events()
        notifier.process_events()

def main():
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    options = _get_argument_parser().parse_args()

    manage_py = _get_manage_py()
    config_file = os.path.join(os.path.dirname(manage_py),
                               '.djrunserver.config.json')

    config = {}
    if os.path.isfile(config_file):
        logger.info("Loading config from '%s'", config_file)
        try:
            config = _read_config(config_file)
        except Exception:  # pylint: disable=broad-except
            logger.exception('Problems reading config')

    runserver = ['python', manage_py, 'runserver']
    hostport = options.hostport

    if 'port' in config and hostport.port is None:
        hostport = hostport._replace(port=config['port'])
    if options.open:
        hostport = hostport._replace(host="0.0.0.0")

    logger.info("Running @ hostport: %s", hostport)
    hostport_arg = _hostport_to_arg(hostport)
    if hostport_arg is not None:
        runserver.append(hostport_arg)

    runserver.extend(options.runserver_args)

    handler = EventHandler()
    notifier = _get_staticfiles_notifier(handler)

    while True:
        _poll_notifier(notifier)
        logger.info('Collecting static files')
        subprocess.call(['python', manage_py, 'collectstatic', '--clear', '--noinput'])
        logger.info('Compressing')
        subprocess.call(['python', manage_py, 'compress'])
        logger.info('Running server... (command:%s)', runserver)
        proc = subprocess.Popen(runserver)
        handler.touched = False
        while proc.poll() is None and not handler.touched:
            try:
                _poll_notifier(notifier)
                time.sleep(1)
            except KeyboardInterrupt:
                logger.info('Ctrl-C! Restarting server')
                break

            if proc.poll() is not None:
                logger.info('Runserver stopped.')

            if handler.touched:
                logger.info('Static files changed.')

        logger.info('Must restart.')
        if proc.poll() is None:
            logger.info("Runserver is still alive, killing it.")
            subprocess.call(['kill', '-9'] + _get_all_pids(proc.pid))
            logger.info("Waiting for server to yield.")
            proc.wait()
            logger.info("Server stopped.")

        logger.info("Restarting server in 1 second...")
        time.sleep(1)


if __name__ == '__main__':
    main()
