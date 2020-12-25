#!/usr/bin/env python3
from sys import argv, stdout
assert len(argv) > 1, 'Usage: {} <anbient-anime-url>'.format(argv[0])

from time import sleep
import os
lock = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'lock')
if os.path.exists(lock):
    input('{} already running.\nPress ENTER to continue'.format(argv[0]))

from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException, TimeoutException
import subprocess as sp

url = argv[1]
save = os.path.join("/home/{}/Downloads".format(os.getlogin()),
    url.split('/')[-1].replace('-', '_'))

opts = webdriver.FirefoxOptions()
#opts.add_argument('-headless')
driver = webdriver.Firefox(executable_path='/usr/bin/geckodriver', options=opts)
try:
    open(lock, 'w').close()
    driver.get(url)
    sleep(0.5)

    for server in ['zippyshare-', 'google-drive-', 'mega-']:
        try:
            el = driver.find_element_by_xpath("//div[contains(@id, '{}')]".format(server))
            break
        except NoSuchElementException:
            el = None

    assert el != None, 'No server found'
    urls = [
        li.find_element_by_tag_name("a").get_attribute("href")
        for li in el.find_elements_by_tag_name("li")
    ]

    if 'zippyshare' in server:
        i = 0
        for url in urls:
            retries = 0
            while retries < 3:
                try:
                    driver.get(url)
                    break
                except TimeoutException as err:
                    print('Error: \033[1;31m{}\033[m'.format(err))
                    c += 1
            print('[{:2}/{:2}] {}'.format(i, len(urls), url))
            stdout.write("\x1b]2; [{:2}/{:2}] {} \x07".format(i, len(urls), url))
            sleep(0.5)
            try:
                command = '/usr/bin/aria2c --retry-wait 5 --dir {} -x 8 {}'.format(save,
                    driver.find_element_by_id("dlbutton").get_attribute('href'))
                i += 1
            except NoSuchElementException as err:
                print(err)
                continue
            try:
                sp.run(command.split())
            except:
                pass
    else:
        print("I don't know what to do yet")

except KeyboardInterrupt:
    os.remove(lock)
finally:
    driver.close()
    os.remove(lock)
    os.remove("geckodriver.log")
