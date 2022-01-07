#!/bin/bash

source $(dirname "${BASH_SOURCE[0]}")/include.sh

docker run -i --rm --name android_coding_sandbox_docker \
    --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
    --device=/dev/kvm \
    --device /dev/nvidia0:/dev/nvidia0 \
    --device /dev/nvidiactl:/dev/nvidiactl \
    --device /dev/nvidia-uvm:/dev/nvidia-uvm \
    --net=host \
    --env="DISPLAY" \
    -v `pwd`:/ws/ \
    -v ${android_docker_deps}:/root/android_docker_deps/ \
    $dockername /bin/bash -c "$@"

