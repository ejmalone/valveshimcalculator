#!/bin/sh

set -ex

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

./bin/dev