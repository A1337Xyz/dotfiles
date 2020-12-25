#!/usr/bin/env python3
from datetime import datetime
from i3ipc import Connection
from os import system
#https://github.com/altdesktop/i3ipc-python

i3 = Connection()
focused = i3.get_tree().find_focused()
name, workspace = focused.name, focused.workspace().name
if len(name) > 40: name = name[:48] + '...'
system('notify-send -t 1000 "{}" "{}"'.format(workspace, name))
