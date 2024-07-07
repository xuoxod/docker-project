#!/usr/bin/env bash
<<COMMENT
    Administrative helper script use for:
        - Adding user to sudo group
        - Adding user to given group
        - Removing user from sudo group
        - Listing user's group(s)
        - Locking user account
        - Unlocking user account
COMMENT
declare -r PATH_TEMPLATE='^((/)?([a-zA-Z]+)(/[a-zA-Z]+/?)?$|/)'
declare -r EXIT_PROG=0
declare -r ROOT_UID=0
declare -r NON_ROOT=121
declare -r EXIT_UNKNOWN_USER=120
declare -r EXIT_UNKNOWN_GROUP=119
declare -r PROG="Path Finder"
declare -r DESC="Administrative helper script use for confirming and/or manipulating paths"

set -e          # Exit if any command has a non-zero exit status
set -u          # Set variables before using them
set -o pipefail # Prevent pipeline errors from being masked
set -m
# set -x Prints command to the console
source patterns.sh

IMAGE_PATH="xuoxod/ubuntu"
IMAGE_NAME="xbuntu"
IMAGE_VER="1.0"
USER_DIR="$HOME"
HOST_PATH="$USER_DIR/private/data"
CONT_PATH="$USER_DIR/private/data"
ARG="docker run -it -d --name $IMAGE_NAME -v $HOST_PATH:$CONT_PATH $IMAGE_PATH:$IMAGE_VER"

clearVars() {
    unset ARG
}

gracefulExit() {
    clearVars
    exit "$EXIT_PROG"
}

exitProg() {
    gracefulExit
}

trap "gracefulExit" INT TERM QUIT PWR STOP KILL

while getopts ':hs:' OPTION; do
    case "${OPTION}" in
    *)
        printf "$ARG\n\n"
        ;;

    ?)
        noOptionErr
        ;;
    esac
done
shift "$(($OPTIND - 1))"
