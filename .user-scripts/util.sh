#! /usr/bin/bash

set -e
set -u
source colorprint.sh

clearVars() {
    unset color text filebase filename extension
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
    userInput=$1
    if [ -z "$userInput" ]; then
        text="Argument is empty"
        white text
    else
        icolor="39"
        msg=$(color -w "You entered:")
        text="$msg $userInput"
        custom icolor text
    fi
    ;;

2)
    text1=$1
    text2=$2

    if [ -z "$text1" ]; then
        text="Argument is empty"
        white text
        gracefulExit
    elif [ -z "$text2" ]; then
        text="Argument 2 is empty"
        white text
        gracefulExit
    else
        msg=$(color -w "You entered:")
        text="$msg $text1 $text2"
        orange text
        gracefulExit
    fi
    ;;

3)
    text1=$1
    text2=$2
    text3=$3

    if [ -z "$text1" ]; then
        text="Argument is empty"
        white text
        gracefulExit
    elif [ -z "$text2" ]; then
        text="Argument 2 is empty"
        white text
        gracefulExit
    elif [ -z "$text3" ]; then
        text="Argument 3 is empty"
        white text
        gracefulExit
    else
        msg=$(color -w "You entered:")
        text="$msg $text1 $text2 $text3"
        orange text
        gracefulExit
    fi
    ;;

*)
    usage
    ;;
esac
gracefulExit
