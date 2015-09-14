#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

import argparse
import logging
import subprocess


logger = logging.getLogger(__name__)  # pylint: disable=invalid-name


_PACKAGES = (
    'ipdb',
    'mock',
    'nose',
    'pylint',
    'tox',
)


_DJANGO_PACKAGES = (
    'pylint-django',
    'pyinotify',
)


def _get_arg_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('--django', action='store_true',
                        help='Install django dev packages')
    return parser


def main():
    options = _get_arg_parser().parse_args()

    # Upgrade pip
    subprocess.call(['pip', 'install', '--upgrade', 'pip'])

    packages = list(_PACKAGES)
    if options.django:
        packages.extend(_DJANGO_PACKAGES)

    subprocess.call(['pip', 'install', '--upgrade', '--upgrade'] + packages)


if __name__ == '__main__':
    main()
