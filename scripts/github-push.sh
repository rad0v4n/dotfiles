#!/usr/bin/env bash

cd /home/user/github/dotfiles

git add --all

git commit -m "Auto $(date '+%H:%M %d.%m.%Y')"

git push origin master
