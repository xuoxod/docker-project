#!/usr/bin/bash
set -e
set -u
set -o pipefail

INTDEC_PATTERN="^([0-9]{1,3})(\.[0-9]{1,2})?$"

clearVars() {
    unset num
}

gracefulExit() {
    clearVars
    exit 0
}

trap "gracefulExit" INT TERM QUIT PWR

if [ $# -eq 0 ]; then
    clear
    printf "\n\t\tdocker images ...\n\n"
    # docker run -it -d xuoxod/ubuntu:
elif [ $# -eq 1 ]; then
    clear
    num="$1"
    if [[ "$num" =~ $INTDEC_PATTERN ]]; then
        printf "\n\t\tdocker run -it -d xuoxod/ubuntu:$num ...\n\n"
        # docker build --no-cache -t "xuoxod/ubuntu:$num" .
    else
        printf "\n\t\tdocker images ...\n\n"
        # docker build --no-cache -t xuoxod/ubuntu:1.0 .
    fi
else
    clear
    printf "\n\t\tdocker images ...\n\n"
    # docker build --no-cache -t xuoxod/ubuntu:1.0 .
fi
gracefulExit
