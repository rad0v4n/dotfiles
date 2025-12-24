#!/usr/bin/env bash

set -e

DIR="$1"

if [ -z "$DIR" ]; then
  echo "Usage: $0 /path/to/repo"
  exit 1
fi

cd "$DIR"

git add --all
git commit -m "Auto $(date '+%H:%M %d.%m.%Y')"
git push origin master
