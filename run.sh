#!/bin/bash

REPOSITORY_NAME="$(basename "$(dirname -- "$( readlink -f -- "$0"; )")")"

docker run -it --rm \
--network=host \
--ipc=host --pid=host \
--env UID=$(id -u) \
--env GID=$(id -g) \
--volume ./resources/rover_node.yaml:/opt/ros/humble/share/septentrio_gnss_driver/config/rover_node.yaml \
ghcr.io/rosblox/${REPOSITORY_NAME}:humble
