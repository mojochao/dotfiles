#!/usr/bin/env python
import os

def uninstall(item):
    dst = os.path.expanduser('~/{}'.format(item))
    if os.path.islink(dst):
        os.unlink(dst)
        print('uninstalled {}'.format(dst))

with open('manifest.in') as infile:
    dotfiles = [i for i in infile.read().split('\n') if i != '']
    map(uninstall, dotfiles)
