#!/usr/bin/bash
set -e
set -u
set -o pipefail

clearVars() {
    unset $@ num
}

gracefulExit() {
    clearVars
    exit 0
}

trap "gracefulExit" INT TERM QUIT PWR

if [ $# -eq 0 ]; then
    clear
    printf "\n\t\tdocker build --no-cache -t xuoxod/ubuntu:1.0 . ...\n\n"
    # docker build --no-cache -t xuoxod/ubuntu:1.0 .
elif [ $# -eq 1 ]; then
    clear
    num="$1"
    if [[ "$num" =~ ^([0-9]{1,3})(\.[0-9]{1,2})?$ ]]; then
        printf "\n\t\tBdocker build --no-cache -t xuoxod/ubuntu:$num" ...\n\n"
        docker build --no-cache -t xuoxod/ubuntu:$num" .
    else
        printf "\n\t\tdocker build --no-cache -t xuoxod/ubuntu:1.0 . ...\n\n"
        # docker build --no-cache -t xuoxod/ubuntu:1.0 .
    fi
else
    printf "Not expecting any arguments\n\n"
fi
gracefulExit
