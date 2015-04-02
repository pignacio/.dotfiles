#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import (
    absolute_import, unicode_literals, division, print_function)

import json
import logging
import os
import subprocess
import sys
import time


logger = logging.getLogger(__name__)  # pylint: disable=invalid-name


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



def main():
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
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
    if 'port' in config:
        runserver.append(str(config['port']))
    runserver.extend(sys.argv[1:])

    while True:
        logger.info('Collecting static files')
        subprocess.call(['python', manage_py, 'collectstatic', '--noinput'])
        logger.info('Compressing')
        subprocess.call(['python', manage_py, 'compress'])
        try:
            logger.info('Running server...')
            subprocess.call(runserver)
        except KeyboardInterrupt:
            # Allow Ctrl-Xing the server
            pass
        logger.info('Runserver stopped. Restarting in 5s')
        time.sleep(5)


if __name__ == '__main__':
    main()
