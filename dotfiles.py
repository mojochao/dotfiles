#!/usr/bin/env python
from __future__ import print_function
import argparse
import os


SRC_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), 'src'))


def install(item):
    src = os.path.join(SRC_DIR, item)
    dst = os.path.expanduser('~/{}'.format(item))
    if not os.path.exists(dst):
        containing_dir = os.path.dirname(dst)
        if not os.path.exists(containing_dir):
            os.makedirs(containing_dir)
        os.symlink(src, dst)
        return 'installed {}'.format(dst)
    else:
        return '{} found and skipped'.format(dst)


def uninstall(item):
    dst = os.path.expanduser('~/{}'.format(item))
    if os.path.islink(dst):
        os.unlink(dst)
        return 'uninstalled {}'.format(dst)
    else:
        return '{} not found and skipped'.format(dst)


def main():
    parser = argparse.ArgumentParser(description='manage dotfiles in home directory')
    parser.add_argument('action', choices=['install', 'uninstall'], help='desired action')
    args = parser.parse_args()

    with open('manifest.in') as infile:
        dotfiles = [i for i in infile.read().split('\n') if i != '']

    results = map(globals()[args.action], dotfiles)
    map(print, results)


if __name__ == '__main__':
    main()
