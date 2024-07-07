#!/usr/bin/bash
set -e
set -u
set -o pipefail

INTDEC_PATTERN="^([0-9]{1,3})(\.[0-9]{1,2})?$"
PATH_PATTERN="^(\/|\.|(\.\/))?[a-zA-Z-]+$"

clearVars() {
    unset num
}

gracefulExit() {
    clearVars
    exit 0
}

trap "gracefulExit" INT TERM QUIT PWR

# Arguments:
#     $1 = image version number
#     $2 = mount path on the host
#     $3 = mount path in the container
#     $4 = container name

if [ $# -eq 0 ]; then
    clear
    printf "\n\t\tdocker run -it -d xuoxod/ubuntu:1.0 ...\n\n"

    # docker run -it -d xuoxod/ubuntu:1.0
elif [ $# -eq 1 ]; then
    clear
    IMAGE_VERSION="$1"
    CONTAINER_NAME="xbuntu"
    pth=""

    if [[ "$IMAGE_VERSION" =~ $INTDEC_PATTERN ]]; then
        printf "\n\t\tdocker run -it -d --name $CONTAINER_NAME xuoxod/ubuntu:$IMAGE_VERSION ...\n\n"

        # docker run -it -d "xuoxod/ubuntu:$IMAGE_VERSION"
    else
        printf "\n\t\tdocker run -it -d xuoxod/ubuntu:1.0 ...\n\n"

        # docker run -it -d xuoxod/ubuntu:1.0
    fi
elif [[ $# -eq 2 ]]; then
    IMAGE_VERSION="$1"
    HOST_MOUNT_PATH="$2"
    CONTAINER_NAME="xbuntu"

    printf "\n\t\tdocker run -it -d --name $CONTAINER_NAME -v "$HOST_MOUNT_PATH:/home/xuaxad/private/data/host" xuoxod/ubuntu:$IMAGE_VERSION ...\n\n"

    # docker run it -d --name xbuntu -v "path:/home/xuaxad/private/data/host" xuoxod/ubuntu:$num"
elif [[ $# -eq 3 ]]; then
    IMAGE_VERSION="$1"
    HOST_MOUNT_PATH="$2"
    CONTAINER_MOUNT_PATH="$3"
    CONTAINER_NAME="xbuntu"

    printf "\n\t\tdocker run -it -d --name $CONTAINER_NAME -v "$HOST_MOUNT_PATH:$CONTAINER_MOUNT_PATH" xuoxod/ubuntu:$IMAGE_VERSION ...\n\n"

    # docker run it -d --name "$CONTAINER_NAME" -v "path:/home/xuaxad/private/data/host" xuoxod/ubuntu:$IMAGE_VERSION"
elif [[ $# -eq 4 ]]; then
    IMAGE_VERSION="$1"
    HOST_MOUNT_PATH="$2"
    CONTAINER_MOUNT_PATH="$3"
    CONTAINER_NAME="$4"

    printf "\n\t\tdocker run -it -d --name $CONTAINER_NAME -v "$HOST_MOUNT_PATH:$CONTAINER_MOUNT_PATH" xuoxod/ubuntu:$IMAGE_VERSION ...\n\n"

    # docker run it -d --name "$CONTAINER_NAME" -v "path:/home/xuaxad/private/data/host" xuoxod/ubuntu:$IMAGE_VERSION"
else
    clear
    printf "\n\t\tdocker run -it -d xuoxod/ubuntu:1.0 ...\n\n"
    # docker run -it -d xuoxod/ubuntu:1.0
fi
gracefulExit
