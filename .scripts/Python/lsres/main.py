#!/usr/bin/env python3
import subprocess as sp
import hashlib
import json
import os

cache_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'cache.json')

extensions = {
    'video': ['mp4', 'avi', 'mkv', 'webm'],
    'image': ['jpg', 'jpeg', 'png'],
}

try:
    with open(cache_path, 'r') as fp:
        cache = json.load(fp)
except FileNotFoundError:
    cache = dict()

BLOCK_SIZE = 64 * 1024

for r, _, f in os.walk('.'):
    if r != '.': break
    for i in f:
        ext = os.path.splitext(i)[-1][1:] 
        if ext in extensions['video'] or ext in extensions['image']: 

            hasher = hashlib.md5()
            with open(i, 'rb') as fp:
                fb = fp.read(BLOCK_SIZE)
                while len(fb) > 0:
                    hasher.update(fb)
                    fb = fp.read(BLOCK_SIZE)
            file_hash = hasher.hexdigest()

            if not file_hash in cache:
                try:
                    if ext in  extensions['video']:
                        output = sp.run(['mediainfo', '--Output=Video;(%Width%, %Height%)', i], stdout=sp.PIPE).stdout
                    else:
                        output = sp.run(['mediainfo', '--Output=Image;(%Width%, %Height%)', i], stdout=sp.PIPE).stdout
                    width, height = eval(output)
                    cache[file_hash] = (width, height) 
                except Exception as err:
                    print(err)
                    exit(1)
            else:
                width, height = cache[file_hash]
            print(' {:>4}x{:<4} : {}'.format(width, height, i.split('/')[-1]))

with open(cache_path, 'w') as fp:
    json.dump(cache, fp)
