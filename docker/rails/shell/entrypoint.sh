#!/bin/bash

# エラーが発生した場合に処理を打ち止めにする
set -e

# railsのserver.pidを削除
rm -f /apps/tmp/pids/server.pid

# Dockerfileのメインプロセスを実行(CMDの部分)
exec "$@"
