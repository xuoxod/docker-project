#!/usr/bin/env bash
<<COMMENT
    Docker helper script
    Run an image
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
VOLUME="$USER_SRC"
HOST_SRC="USER_SRC"
ClIENT_DST="$USER_HOME/private/.data"
ARG="docker run -it -d --name $IMAGE_NAME -v $HOST_SRC:$ClIENT_DST $IMAGE_URL:$IMAGE_VER"
DIRS="cd ~; cd private; mkdir .data .data/scripts/bash .data/images/jpgs .data/images/pngs .data/images/gifs .data/images/tiffs .data/images/svgs .data/texts/information .data/texts/reference .data/texts/files .data/texts/files/pdfs .data/texts/files/txts -p"
DUMMY="cd ~; cd private; ls -halR ./.data"

PAUSE_SECONDS=4
MSG_SECONDS=6
DELAY_SECONDS=2
STATUS_MSG="Checking for the necessary '$USER_SRC' directory\n\n"
PATH_STATUS=1

NAME="myimage"
DOCKER_CMD="docker ps"

clearVars() {
    unset @
}

gracefulExit() {
    clearVars
    exit "$EXIT_PROG"
}

noOptionErr() {
    printf "\n"
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
    echo $DIRS

    printf "Directory '$(pwd)/private/.data' Creation Success!\n\n"
    sleep $MSG_SECONDS
    # clear

    printf "Listing content in the newly created directory: $(pwd)/private/.data\n\n"

    ls "$USER_SRC"
    sleep $PAUSE_SECONDS

    printf "\n\nListing detailed content in the $(pwd)/private/.data directory\n\n"
    ls -lah "$USER_SRC"
    sleep $PAUSE_SECONDS

    STATUS_MSG="Re-Checking for the necessary '$USER_SRC' directory\n\n"

    checkPathReadAndWrite
    # exit 0
    # fi

}

checkPathExist() {
    printf "$STATUS_MSG"
    sleep $DELAY_SECONDS

    if ! [[ -e "$USER_SRC" ]]; then
        STATUS_MSG="Path $USER_SRC Does NOT Exists\n\n"
        PATH_STATUS=1
    else
        PATH_STATUS=0
    fi
}

checkPathReadAndWrite() {
    printf "$STATUS_MSG"

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
}

initProg() {
    checkPathExist

    if [[ $PATH_STATUS -eq 0 ]]; then
        checkPathReadAndWrite
    else
        createPaths
    fi
    gracefulExit
}

trap "gracefulExit" INT TERM QUIT PWR STOP KILL

while getopts ':?u:n:v:s:t' OPTION; do
    case "${OPTION}" in
    t)
        printf "Argument Count: $#\n"
        printf "Option: ${OPTION}\n"
        printf "Option Index: ${OPTIND}\n\n"
        initProg
        ;;

    u)
        # if [[ $# -eq 2 ]]; then
        optInd="$OPTIND"
        optArg="$OPTARG"
        IMAGE_URL="${OPTARG}"
        printf "Argument Count: $#\n"
        printf "Option Index: $optInd\n"
        printf "Option Argument: $optArg\n"
        printf "Image URL: ${IMAGE_URL}\n\n"
        # else
        #     printf "\n\tMissing Argument\nFlag ${OPTION} requires Path/URL To The Image You Want\n\n"
        # fi
        DOCKER_CMD="docker run -it -d --name $NAME $IMAGE_URL "
        ;;

    n)
        # if [[ $# -eq 2 ]]; then
        optInd="$OPTIND"
        optArg="$OPTARG"
        NAME="${OPTARG}"
        printf "Argument Count: $#\n"
        printf "Option Index: $optInd\n"
        printf "Option Argument: $optArg\n"
        printf "Container Run-Time Name: ${NAME}\n\n"
        # else
        #     printf "\n\tMissing Argument\nFlag ${OPTION} requires Path/URL To The Image You Want\n\n"
        # fi
        DOCKER_CMD="docker run -it -d --name $NAME $IMAGE_URL "
        ;;

    v)
        # if [[ $# -eq 2 ]]; then
        optInd="$OPTIND"
        optArg="$OPTARG"
        VOLUME="${OPTARG}"
        printf "Argument Count: $#\n"
        printf "Option Index: $optInd\n"
        printf "Option Argument: $optArg\n"
        printf "Volume Paths: $VOLUME\n\n"
        # else
        #     printf "\n\tMissing Argument\nFlag ${OPTION} requires Path/URL To The Host's Data File Or Directory\n\n"
        # fi
        DOCKER_CMD="docker run -it -d --name $NAME -v $VOLUME $IMAGE_URL"
        ;;

    ?)
        noOptionErr
        ;;
    esac
done
shift "$(($OPTIND - 1))"

printf "\n\n\t\t Docker Command Final Statement\n$DOCKER_CMD\n\n"
$DOCKER_CMD
