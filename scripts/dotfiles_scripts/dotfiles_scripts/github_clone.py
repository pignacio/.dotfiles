#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import (
    absolute_import, unicode_literals, division, print_function)

import argparse
import logging
import os
import subprocess


logger = logging.getLogger(__name__)  # pylint: disable=invalid-name


def _get_arg_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument("repo",
                        help=("Github repo to clone, in <user>/<repo> format. "
                              "If user is ommited, the current directory name "
                              "will be used as the username."))
    parser.add_argument("clone_args", nargs="*",
                        help=("Extra arguments for the git clone command."))
    return parser


def main():
    options = _get_arg_parser().parse_args()
    if "/" in options.repo:
        user, repo = options.repo.split("/", 1)
    else:
        repo = options.repo
        user = os.path.basename(os.path.abspath(os.path.curdir))

    repo_url = "git@github.com:{}/{}".format(user, repo)
    print("Cloning repo: {}".format(repo_url))
    print("git clone args: {}".format(options.clone_args))
    subprocess.call(['git', 'clone', repo_url] + options.clone_args)



if __name__ == '__main__':
    main()
