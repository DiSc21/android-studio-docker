#!/bin/bash

source $(dirname "${BASH_SOURCE[0]}")/include.sh

echo "WTF run_docker"

docker run -i --rm --name ${as_docker_name} \
    --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
    --device=/dev/kvm \
    --device /dev/nvidia0:/dev/nvidia0 \
    --device /dev/nvidiactl:/dev/nvidiactl \
    --device /dev/nvidia-uvm:/dev/nvidia-uvm \
    --net=host \
    --env="DISPLAY" \
    -v `pwd`:/ws/ \
    -v ${android_docker_deps}:/root/ \
    $as_docker_name_tag /bin/bash -c "$@"

