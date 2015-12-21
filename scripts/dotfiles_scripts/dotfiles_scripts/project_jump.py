#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

import argparse
import collections
import json
import logging
import re
import os


logger = logging.getLogger(__name__)  # pylint: disable=invalid-name


DEFAULT_CONFIG_FILE = os.path.expanduser('~/.project_jump.config')
META_PROJECT_SEPARATOR_RE = r"[:{}]".format(os.sep)


Config = collections.namedtuple('Config', ['projects_dirs'])
ProjectDirConfig = collections.namedtuple('ProjectDirConfig', ['meta_projects'])


def project_dir_config_from_json(jobj):
    return ProjectDirConfig(
        meta_projects=jobj.get('meta_projects', []),
    )


def config_from_file(filename):
    with open(filename) as fin:
        jobj = json.load(fin)
    return config_from_json(jobj)


def config_from_json(jobj):
    projects_dirs = {
        k: project_dir_config_from_json(v)
        for k, v in jobj.get('projects_dirs', {}).items()
    }
    return Config(
        projects_dirs=projects_dirs,
    )


def get_arg_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('project', action='store', type=Project.from_path,
                        nargs="?", help='project to jump to')
    parser.add_argument('--list',
                        action='store_true',
                        help="List projects")
    parser.add_argument('--compleat',
                        action='store_true',
                        help="List projects completion. Overrides --list")
    parser.add_argument('-c', '--config',
                        action='store', default=DEFAULT_CONFIG_FILE,
                        help="Config file to use. Defaults to '{}'".format(
                            DEFAULT_CONFIG_FILE))
    return parser


def get_projects(directory, dir_config):
    def _get_projects(direc):
        return set(x for x in os.listdir(direc)
                   if os.path.isdir(os.path.join(direc, x)))
    directory = os.path.expanduser(directory)
    projects = _get_projects(directory)
    for meta_project in dir_config.meta_projects:
        if meta_project in projects:
            projects.remove(meta_project)
            projects.update(os.path.join(meta_project, sp)
                            for sp in _get_projects(os.path.join(directory,
                                                                 meta_project)))
    return [Project.from_path(p, parent_dir=directory) for p in projects]


_Project = collections.namedtuple('Project', ['meta', 'name', 'parent_dir'])


class Project(_Project):
    @classmethod
    def from_path(cls, path, parent_dir=None):
        try:
            meta, name = re.split(META_PROJECT_SEPARATOR_RE, path, 1)
        except (ValueError, TypeError):
            return cls(meta='', name=path, parent_dir=parent_dir)
        else:
            return cls(meta=meta, name=name, parent_dir=parent_dir)

    def as_path(self):
        if self.meta:
            return os.sep.join([self.meta, self.name])
        return self.name


def _matches(needle, haystack):
    current = 0
    indexes = []
    for char in needle:
        current = haystack.find(char, current)
        if current == -1:
            return None
        indexes.append(current)
        current += 1
    return indexes


def _match_score(indexes):
    return (sum(b - a - 1 for a, b in zip(indexes, indexes[1:])),
            indexes[0] if indexes else 0)


def _project_matches(project, needle):
    return (_matches(needle.meta, project.meta) is not None and
            _matches(needle.name, project.name) is not None)


def main():
    options = get_arg_parser().parse_args()
    if not (options.list or options.compleat or options.project):
        raise ValueError("Must supply --list or --compleat or a project")
    config = config_from_file(options.config)
    projects = set()
    for dirname, dir_config in config.projects_dirs.items():
        projects.update(get_projects(dirname, dir_config))
    if options.project:
        projects = [p for p in projects if _project_matches(p, options.project)]
    if options.compleat:
        completions = set(p.as_path() for p in projects)
        completions.update(p.name for p in projects)
        for name in sorted(completions):
            print name
    elif options.list:
        for project in sorted(projects):
            print project.as_path()
    else:
        print "Searching for project: {}".format(options.project.as_path())
        scored_projects = [
            (_match_score(_matches(options.project.name, p.name)), p)
            for p in projects
        ]
        if scored_projects:
            print "Matching projects:"
            for score, project in sorted(scored_projects):
                print " -", project.as_path(), score
            best_project = sorted(scored_projects)[0][1]
            switch_to_project(best_project)
        else:
            print "No matching projects for '{}'".format(
                options.project.as_path())


def get_cd_location(project_dir):
    for path, dummy_subdirs, files in os.walk(project_dir):
        if 'manage.py' in files:
            return os.path.join(project_dir, path)
    return project_dir


def switch_to_project(project):
    print "Switching to '{}'".format(project.as_path())
    project_dir = os.path.join(project.parent_dir,
                               project.as_path())
    print "@cd:{}".format(get_cd_location(project_dir))

    # virtualenvwrapper
    for venv in [project.as_path().replace(os.sep, "."),
                 project.name]:
        path = os.path.join(os.path.expanduser("~"), ".virtualenvs", venv)
        if os.path.isdir(path):
            print "Found virtualenvwrapper: '{}'".format(venv)
            print "@workon:{}".format(venv)
            break
    else:
        # possible virtualenvs:
        local_venvs_dir = os.path.join(os.path.expanduser('~'), '.local',
                                       'venvs')
        for venv in [
                os.path.join(project_dir, 'venv'),
                os.path.join(local_venvs_dir, project.as_path()),
                os.path.join(local_venvs_dir, project.name),
        ]:
            activate_path = os.path.join(venv, 'bin', 'activate')
            if os.path.isfile(activate_path):
                print "Found virtualenv: {}".format(venv)
                print "@source:{}".format(activate_path)


if __name__ == '__main__':
    main()
