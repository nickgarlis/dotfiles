#!/bin/sh

set -e

git remote update > /dev/null

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

fetch_and_install () {
  git pull -q origin master
  ./install.sh
}

if [ $LOCAL = $REMOTE ]; then
  echo 'Everything is up to date'
elif [ $LOCAL = $BASE ]; then
  echo '[*] Updating ...'
  fetch_and_install
elif [ $REMOTE = $BASE ]; then
  echo 'Need to push'
else
  echo 'Diverged'
fi
