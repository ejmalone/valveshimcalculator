#!/bin/sh

set -ex

# remove leftover pid in case the server was running outside of docker
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

./bin/dev