#!/bin/bash
set -ex

if [ -f ./docker/dev/dynamic/env ]; then
  set -a && source ./docker/dev/dynamic/env && set +a
fi

ln -sf ../../docker/dev/post-commit .git/hooks/post-commit
chmod +x .git/hooks/post-commit

git describe --tags >CURRENT_VERSION

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# If running the rails server then create or migrate existing database
if [ "${@:1:1}" == "./bin/rails" ] && [ "${@:2:1}" == "server" ]; then
  ./bin/rails db:prepare
  ./bin/rails db:seed
  ./bin/rails data:migrate
fi

exec "${@}"
