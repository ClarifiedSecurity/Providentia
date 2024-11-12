#!/bin/bash
set -ex

# Enable jemalloc for reduced memory usage and latency.
if [ -z "${LD_PRELOAD+x}" ]; then
  LD_PRELOAD=$(find /usr/lib -name libjemalloc.so.2 -print -quit)
  export LD_PRELOAD
fi

# If running the rails server then create or migrate existing database
if [ "${@:1:1}" == "./bin/rails" ] && [ "${@:2:1}" == "server" ]; then
  ./bin/rails db:prepare
  ./bin/rails db:seed
  ./bin/rails data:migrate
fi

exec "${@}"
