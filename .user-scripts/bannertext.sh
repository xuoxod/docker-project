#! /usr/bin/bash

set -e
set -u
source colorprint.sh

clearVars() {
    unset text filebase filename extension
}

gracefulExit() {
    clearVars
    exit 0
}

usage() {
    text='bannertext <"Double Quoted Text">\n'
    white text
    text='bannertext <"Double Quoted Text"> <Path to banner file>\n'
    white text
    gracefulExit
}

trap "gracefulExit" INT PWR QUIT TERM

case $# in
1)
    text=$1
    if [ -z "$text" ]; then
        text="Argument is empty"
        orange text
    else
        icolor="39"
        custom color text
    fi
    ;;

2)
    text=$1
    filepath=$2
    if [ -z "$text" ]; then
        text="The message is empty"
        white text
    elif [ ! -e "$filepath" ]; then
        text="$filepath does not exist"
        white text
    elif [ ! -f "$filepath" ]; then
        text="$filepath is not a file"
        white text
    elif [ ! -w "$filepath" ]; then
        text="$filepath is not writable"
        white text
    else
        filebase=$(basename "$filepath")
        filename=${filebase%.*}
        extension=${filebase##*.}

        if [ "$filename" != "motd" ]; then
            text="Must write to the motd file"
            white "$text"
        elif [ "$filepath" != "/etc/motd" ]; then
            text="This program will only write to a writalbe /etc/motd file"
            white text
        else
            text=$(figlet -cptW "$text")
            blue text >"$filepath"
        fi
    fi
    ;;

*)
    usage
    ;;
esac
gracefulExit
