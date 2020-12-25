#!/usr/bin/env python3
from sys import argv
assert len(argv) > 1
from bs4 import BeautifulSoup as BS
from urllib.request import Request, urlopen

USER_AGENT = "Mozilla/5.0 (X11; U; Linux i686) Gecko/20071127 Firefox/2.0.0.11"

def main(url):
    r = Request(url, headers = {'User-Agent': USER_AGENT})
    with urlopen(r) as data:
        soup = BS(data.read().decode(), 'html.parser')
    for p in soup.find('div', {'class': 'mxm-lyrics'}).find_all('p'):
        print(p.text)

if __name__ == '__main__': main(argv[1])

