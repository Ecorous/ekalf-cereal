#!/usr/bin/env python3

import os

cdir = os.getcwd()
flake_dir = "/home/ecorous/ekalf-cereal"

os.chdir(flake_dir)
git_out = os.popen("git status -uno").read()
check_line = git_out.split("\n")[1]
#print(check_line)

message = ""
body = ""

if not check_line.startswith("Your branch is up to date with"):
    message = "out of date"
    body = "Please ensure the git repo is synced - and then run \"nixos-switch\""
else:
    message = "up to date"
    body = "Make sure it stays this way!"

command = f"notify-send -a \"System Update Checker\" \"Your system is {message}\" \"{body}\" -t 120000"
print(command)
os.system(command)
