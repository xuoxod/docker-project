#!/usr/bin/bash

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

PAUSE_SECONDS=4
MSG_SECONDS=6
DELAY_SECONDS=2

CACHE="--no-cache"
IMAGE_TAG="${USERNAME}/${DESKTOP_SESSION}"
IMAGE_VER="0.1"
DOCKER_CMD="docker build $CACHE $IMAGE_TAG:$IMAGE_VER ."

clearVars() {
    unset CACHE IMAGE_URL IMAGE_VER
}

gracefulExit() {
    clearVars
    exit 0
}

noOptionErr() {
    printf "\n\n"

}

trap "gracefulExit" INT TERM QUIT PWR STOP KILL

# OPTIONS:
#    c: control caching
#    t: image tag name
#    v: image version
while getopts ':?c:t:v:' OPTION; do
    case "${OPTION}" in
    c)
        # Cache: default --no-cache
        optInd="${OPTIND}"
        option="${OPTION}"
        CACHE="${OPTARG}"
        DOCKER_CMD="docker build $CACHE -t $IMAGE_TAG:$IMAGE_VER ."
        printf "Option:\t${option}\n"
        # printf "docker build $CACHE -t $IMAGE_URL:$IMAGE_VER\n\n"
        ;;

    t)
        # Image tAG: default $USERNAME/$DESKTOP_SESSION
        optInd="${OPTIND}"
        option="${OPTION}"
        IMAGE_TAG="${OPTARG}"
        DOCKER_CMD="docker build $CACHE -t $IMAGE_TAG:$IMAGE_VER ."
        printf "Option:\t${option}\n"
        # printf "docker build $CACHE -t $IMAGE_URL:$IMAGE_VER\n\n"
        ;;

    v)
        # Image Version: default 1.0
        optInd="${OPTIND}"
        option="${OPTION}"
        IMAGE_VER="${OPTARG}"
        DOCKER_CMD="docker build $CACHE -t $IMAGE_TAG:$IMAGE_VER ."
        printf "Option:\t${option}\n"
        # printf "docker build $CACHE -t $IMAGE_URL:$IMAGE_VER\n\n"
        ;;

    ?)
        noOptionErr
        ;;
    esac
done
shift "$(($OPTIND - 1))"

printf "\n\n\t\t Docker Command Final Statement\n\n"
printf "\t $DOCKER_CMD\n\n"

# $DOCKER_CMD
