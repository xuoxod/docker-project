#!/usr/bin/env bash
<<COMMENT
    Docker helper script
COMMENT
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

IMAGE_URL="xuoxod/ubuntu"
IMAGE_NAME="xbuntu"
IMAGE_VER="1.0"
USER_HOME="$HOME"
HOST_SRC="$USER_HOME/private/data"
CONT_DST="$USER_HOME/private/data"
ARG="docker run -it -d --name $IMAGE_NAME -v $HOST_SRC:$CONT_DST $IMAGE_URL:$IMAGE_VER"
DIRS="cd ~; cd private; mkdir .data .data/scripts/bash .data/images/jpgs .data/images/pngs .data/images/gifs .data/images/tiffs .data/images/svgs .data/texts/information .data/texts/reference .data/texts/files .data/texts/files/pdfs .data/texts/files/txts -p"

PAUSE_SECONDS=4
MSG_SECONDS=6
DELAY_SECONDS=2

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

checkPaths() {
    if ! [[ -e "$USER/private" ]]; then
        cd ~
        pwd
        sleep $PAUSE_SECONDS
        printf "Creating the necessary directory child in parent $(pwd)\n\n"
        sleep $PAUSE_SECONDS
        # mkdir private
        printf "Directory '$(pwd)/private' Creation Success!\n\n"
        sleep $MSG_SECONDS
        clear
        printf "Listing newly created $(pwd)/private directory\n\n"
        ls "$(pwd)/private"
        sleep $PAUSE_SECONDS
        printf "\n\nListing all content in the $(pwd) directory\n\n"
        sleep $PAUSE_SECONDS
        ls -lah "$(pwd)/private"
        sleep $DELAY_SECONDS
        exit 0
    fi

}

initProg() {
    checkPaths
}

trap "gracefulExit" INT TERM QUIT PWR STOP KILL

while getopts ':hs:' OPTION; do
    case "${OPTION}" in
    *)
        printf "$ARG\n\n"
        initProg
        ;;

    ?)
        noOptionErr
        ;;
    esac
done
shift "$(($OPTIND - 1))"
