#!/bin/sh
set -e

if [ $(ls ~/.komodo | wc -l) -ne 0 ]; then
  echo "> ~/.komodo not empty: using existing data"
else
  echo "> ~/.komodo is empty: using default conf"
  mv /root/komodo.conf.default ~/.komodo/komodo.conf  
fi

exec "$@"

