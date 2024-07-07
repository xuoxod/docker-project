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
USER_SRC="$HOME/private/.data"
HOST_SRC="USER_SRC"
ClIENT_DST="$USER_HOME/private/.data"
ARG="docker run -it -d --name $IMAGE_NAME -v $HOST_SRC:$ClIENT_DST $IMAGE_URL:$IMAGE_VER"
DIRS="cd ~; cd private; mkdir .data .data/scripts/bash .data/images/jpgs .data/images/pngs .data/images/gifs .data/images/tiffs .data/images/svgs .data/texts/information .data/texts/reference .data/texts/files .data/texts/files/pdfs .data/texts/files/txts -p"

PAUSE_SECONDS=4
MSG_SECONDS=6
DELAY_SECONDS=2

clearVars() {
    unset @
}

gracefulExit() {
    clearVars
    exit "$EXIT_PROG"
}

exitProg() {
    gracefulExit
}

createPaths() {
    # if [[ -e "$USER_SRC" ]]; then
    cd ~
    printf "Just arrived in the $HOME directory\n\n"
    sleep $PAUSE_SECONDS

    printf "Here ... I'll Prove It ...\n\n"
    sleep $PAUSE_SECONDS
    pwd
    sleep $PAUSE_SECONDS

    printf "\n\nCreating the necessary directory child in parent $(pwd)/private\n\n"
    sleep $PAUSE_SECONDS
    # This variable contains the command text to execute in the console
    # $(DIRS)

    printf "Directory '$(pwd)/private/.data' Creation Success!\n\n"
    sleep $MSG_SECONDS
    # clear

    printf "Listing content in the newly created directory: $(pwd)/private/.data\n\n"

    ls "$USER_SRC"
    sleep $PAUSE_SECONDS

    printf "\n\nListing detailed content in the $(pwd)/private/.data directory\n\n"
    ls -lah "$USER_SRC"
    sleep $PAUSE_SECONDS

    printf "\n\n\t\t Good Bye!!\n\n"
    sleep $DELAY_SECONDS
    # exit 0
    # fi

}

checkPaths() {
    printf "Checking for the necessary '$USER_SRC' directory\n\n"
    sleep $DELAY_SECONDS

    if ! [[ -e "$USER_SRC" ]]; then
        createPaths
    else
        printf "Directory '$USER_SRC' Exists ... So Will Check Read and Write Ability\n\n"

        if [[ -r "$USER_SRC" ]]; then
            printf "Directory $USER_SRC Is Readable\n\n"
            sleep $PAUSE_SECONDS
        else
            printf "Directory $USER_SRC Is NOT Readable\n\n"
            sleep $PAUSE_SECONDS
        fi

        if [[ -w "$USER_SRC" ]]; then
            printf "Directory $USER_SRC Is Writable\n\n"
            sleep $PAUSE_SECONDS
        else
            printf "Directory $USER_SRC Is NOT Writable\n\n"
            sleep $PAUSE_SECONDS
        fi
    fi
    gracefulExit
}

initProg() {
    checkPaths
}

trap "gracefulExit" INT TERM QUIT PWR STOP KILL

while getopts ':hs:' OPTION; do
    case "${OPTION}" in
    *)
        initProg
        ;;

    ?)
        noOptionErr
        ;;
    esac
done
shift "$(($OPTIND - 1))"
