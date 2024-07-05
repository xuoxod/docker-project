#!/usr/bin/bash
set -e
set -u
set -o pipefail

clearVars() {
    unset $@
}

gracefulExit() {
    clearVars
    exit 0
}

trap "gracefulExit" INT TERM QUIT PWR

if [ $# -eq 0 ]; then
    clear
    docker build --no-cache -t xuoxod/ubuntu:1.0 .
else
    printf "Not expecting any arguments\n\n"
fi
gracefulExit
