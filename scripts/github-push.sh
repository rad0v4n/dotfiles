#!/usr/bin/env bash

set -e

DIR="$1"
BRANCH="${2:-master}"  # Default to 'master' if no branch is provided

if [ -z "$DIR" ]; then
  echo "Usage: $0 /path/to/repo [branch]"
  exit 1
fi

cd "$DIR"

git add --all
git commit -m "Auto $(date '+%H:%M %d.%m.%Y')"
git push origin "$BRANCH"
