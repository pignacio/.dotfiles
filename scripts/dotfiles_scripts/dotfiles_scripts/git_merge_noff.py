#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals, division

import argparse
import logging
import os
import subprocess
import sys

import git
from pignacio_scripts.terminal.color import (bright_red, bright_green,
                                             bright_yellow)

logger = logging.getLogger(__name__)  # pylint: disable=invalid-name


def _get_argument_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('branch', help='branch to merge.')
    parser.add_argument(
        '--skip-tests',
        action='store_true',
        default=False,
        help='Skip running the tests and merge without looking!')
    parser.add_argument(
        '--into',
        action='store_true',
        default=False,
        help=('Merge the current branch into <branch>, instead of the other '
              'way around'))
    return parser

_MAKEFILE_FILENAMES = [
    'makefile',
    'Makefile',
]  # yapf: disable


def _get_makefile():
    for fname in _MAKEFILE_FILENAMES:
        if os.path.isfile(fname):
            return fname


def _run_tests():
    makefile = _get_makefile()
    if makefile:
        with open(makefile) as fin:
            if any(l.startswith('test:') for l in fin):
                print bright_green('Running tests from makefile: {}'.format(
                    os.path.abspath(makefile)))
                return subprocess.call(['make', 'test']) == 0
    if os.path.isfile('manage.py'):
        print bright_green('Running tests from manage.py')
        return subprocess.call(['python', 'manage.py', 'test']) == 0
    return True


def _needs_rebase(base, to_merge):
    repo = base.repo
    return bool(list(repo.iter_commits('{}..{}'.format(to_merge, base),
                                       max_count=1)))


def main():
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    options = _get_argument_parser().parse_args()

    repo = git.Repo('.', search_parent_directories=True)

    branch = repo.branches[options.branch]

    if options.into:
        to_merge = repo.active_branch
        base = branch
    else:
        to_merge = branch
        base = repo.active_branch

    if _needs_rebase(base, to_merge):
        print bright_red('To merge "{}" into "{}" you must rebase its '
                         'contents first!'.format(to_merge, base))
        return

    if options.skip_tests:
        print bright_yellow('Skipping tests')
        tests_passed = True
    else:
        tests_passed = _run_tests()

    if tests_passed:
        print bright_green('Merging "{}" into "{}"'.format(to_merge, base))
        active_branch = repo.active_branch

        base.checkout()
        try:
            if subprocess.call(['git', 'merge', '--no-ff',
                                to_merge.name]) != 0:
                print bright_red('Something went wrong merging. '
                                 'Restoring original branch')
                active_branch.checkout()
        except Exception:
            active_branch.checkout()
            raise
    else:
        print bright_red('Tests FAILED! Not merging.')


if __name__ == '__main__':
    main()
