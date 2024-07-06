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
    printf "\n\t\tBuilding docker image v1.0 ...\n\n"
    # docker build --no-cache -t xuoxod/ubuntu:1.0 .
elif [ $# -eq 1 ]; then
    # Assume the first argument is the version number
    clear
    num="$1"
    if [[ "$num" =~ ^([0-9]{1,3})(\.[0-9]{1,2})?$ ]]; then
        # printf "\n\t$num is a number\n\n"
        printf "\n\t\tBuilding docker image v$num ...\n\n"
        # docker build --no-cache -t "xuoxod/ubuntu:$num" .
    else
        # printf "\n\t\tWho knows what $num is supposed to be\n\n"
        printf "\n\t\tBuilding docker image v1.0 ...\n\n"
        # docker build --no-cache -t xuoxod/ubuntu:1.0 .
    fi
else
    printf "Not expecting any arguments\n\n"
fi
gracefulExit
