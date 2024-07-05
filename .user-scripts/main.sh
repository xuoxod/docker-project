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
declare -r PROG="Manage User Account"
declare -r DESC="Administrative helper script use for: Adding user to sudo group, Removing user from sudo group,
Listing user's group(s), Locking user account and Unlocking user account."

set -e          # Exit if any command has a non-zero exit status
set -u          # Set variables before using them
set -o pipefail # Prevent pipeline errors from being masked
# set -x Prints command to the console
source colortext.sh

clearVars() {
    unset $@ arg
}

gracefulExit() {
    clearVars
    exit "$EXIT_PROG"
}

exitProg() {
    gracefulExit
}

trap "gracefulExit" INT PWR QUIT TERM

case $# in
0)
    # printf -- '%.0s-' {1..66}
    text=$(printf -- '%.0s-' {1..66})
    red
    printf "$text\n"

    text=$(printf -- '%.0s-' {1..66})
    white
    printf "$text\n"

    text=$(printf -- '%.0s-' {1..66})
    blue
    printf "$text\n"
    printf "\n"
    ;;

1)
    arg=$1
    if [[ "$arg" =~ $PATH_TEMPLATE ]]; then
        if [ -e "$arg" ]; then
            printf "Path [$arg] exists\n"
            if [ -f "$arg" ]; then
                printf "Path [$arg] is a file\n"
                if [ -r "$arg" ]; then
                    printf "File [$arg] is readable\n"
                    if [ -w "$arg" ]; then
                        printf "File [$arg] is writable\n"
                    else
                        text=$(printf "File [$arg] is not writable\n")
                        red
                        printf "$text\n"
                    fi
                else
                    text=$(printf "File [$arg] is not readable\n")
                    red
                    printf "$text\n"
                fi
            else
                if [ -d "$arg" ]; then
                    printf "Path [$arg] is a directory\n"
                    if [ -r "$arg" ]; then
                        printf "Directory [$arg] is readable\n"
                        if [ -w "$arg" ]; then
                            printf "Directory [$arg] is writable\n"
                        else
                            text=$(printf "Directory [$arg] is not writable\n")
                            red
                            printf "$text\n"
                        fi
                    else
                        text=$(printf "Directory [$arg] is not readable\n")
                        red
                        printf "$text\n"
                    fi
                else
                    text=$(printf "Path [$arg] is not a regular nor is it a directory\n")
                    red
                    printf "$text\n"
                fi
            fi
        else
            text=$(printf "Path [$arg] does not exist\n")
            red
            printf "$text\n"
        fi
    else
        text=$(printf "[${arg^^}] is not a valid path\n")
        red
        printf "$text\n"
    fi
    ;;

esac
gracefulExit
