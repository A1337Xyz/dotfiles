#!/usr/bin/env python3
import subprocess as sp
import json
import os

cache_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'cache.json')

try:
    with open(cache_path, 'r') as fp:
        cache = json.load(fp)
except FileNotFoundError:
    cache = dict()

for r, _, f in os.walk('.'):
    if r != '.': break
    for i in f:
        rpath = os.path.join(os.path.realpath('.'), i)
        if os.path.splitext(i)[-1][1:] in ['mp4', 'avi', 'mkv', 'webm']:
            if not rpath in cache:
                try:
                    output = sp.run(['mediainfo', '--Output=Video;(%Width%, %Height%)', i], stdout=sp.PIPE).stdout
                    width, height = eval(output)
                    cache[rpath] = (width, height) 
                except Exception as err:
                    print(err)
                    exit(1)
            else:
                width, height = cache[rpath]
            print(' {:>4}x{:<4} : {}'.format(width, height, i.split('/')[-1]))
with open(cache_path, 'w') as fp:
    json.dump(cache, fp)

