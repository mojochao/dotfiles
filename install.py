#!/usr/bin/env python
import os

src_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), 'src'))
print(src_dir)

def install(item):
    src = os.path.join(src_dir, item)
    dst = os.path.expanduser('~/{}'.format(item))
    if not os.path.exists(dst):
        containing_dir = os.path.dirname(dst)
        if not os.path.exists(containing_dir):
            os.makedirs(containing_dir)
        os.symlink(src, dst)
        print('installed {} -> {}'.format(dst, src))
    else:
        print('skipped {}'.format(dst))

with open('manifest.in') as infile:
    dotfiles = [i for i in infile.read().split('\n') if i != '']
    map(install, dotfiles)
