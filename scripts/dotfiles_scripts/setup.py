#!/usr/bin/env python
# -*- coding: utf-8 -*-


try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup


with open('README.rst') as readme_file:
    readme = readme_file.read()

with open('HISTORY.rst') as history_file:
    history = history_file.read().replace('.. :changelog:', '')

requirements = [
    # TODO: put package requirements here
]

test_requirements = [
    # TODO: put package test requirements here
]

setup(
    name='dotfiles_scripts',
    version='0.0.1',
    description="Python scripts used in my dotfiles",
    long_description=readme + '\n\n' + history,
    author="Ignacio Rossi",
    author_email='rossi.ignacio@gmail.com ',
    url='https://github.com/pignacio/dotfiles_scripts',
    packages=[
        'dotfiles_scripts',
    ],
    package_dir={'dotfiles_scripts':
                 'dotfiles_scripts'},
    include_package_data=True,
    install_requires=requirements,
    license='GPLv3',
    zip_safe=False,
    keywords='dotfiles_scripts',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
        'Natural Language :: English',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
    ],
    test_suite='tests',
    tests_require=test_requirements,
    entry_points={
        'console_scripts': [
            'project_jump=dotfiles_scripts.project_jump:main',
            'initvirtualenv=dotfiles_scripts.init_virtualenv:main',
            'ghclone=dotfiles_scripts.github_clone:main',
        ],
    },
)
