#!/usr/bin/env python
from __future__ import print_function
from argparse import ArgumentParser
from os import makedirs, path, symlink, unlink


MANIFEST_FILE = 'manifest.in'
SRC_DIR = path.abspath(path.join(path.dirname(__file__), 'src'))


def install(item):
    src = path.join(SRC_DIR, item)
    dst = path.expanduser('~/{}'.format(item))
    if not path.exists(dst):
        containing_dir = path.dirname(dst)
        if not path.exists(containing_dir):
            makedirs(containing_dir)
        symlink(src, dst)
        return 'installed {}'.format(dst)
    else:
        return '{} found and skipped'.format(dst)


def uninstall(item):
    dst = path.expanduser('~/{}'.format(item))
    if path.islink(dst):
        unlink(dst)
        return 'uninstalled {}'.format(dst)
    else:
        return '{} not found and skipped'.format(dst)


def main():
    parser = ArgumentParser(description='manage dotfiles in home directory')
    parser.add_argument('action', choices=['install', 'uninstall'], help='desired action')
    args = parser.parse_args()

    with open(MANIFEST_FILE) as infile:
        dotfiles = [i for i in infile.read().split('\n') if i != '']

    results = map(globals()[args.action], dotfiles)
    map(print, results)


if __name__ == '__main__':
    main()
