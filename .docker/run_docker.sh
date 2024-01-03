#!/bin/bash

source $(dirname "${BASH_SOURCE[0]}")/include.sh

echo "WTF run_docker"

docker run -i --rm --name ${as_docker_name} \
    --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
    --device=/dev/kvm \
    --device /dev/nvidia0:/dev/nvidia0 \
    --device /dev/nvidiactl:/dev/nvidiactl \
    --device /dev/nvidia-uvm:/dev/nvidia-uvm \
    --privileged \
    --net=host \
    --env="DISPLAY" \
    -v `pwd`:/ws/ \
    -v ${android_docker_home_volume}:/home/${user_name} \
    -u ${user_id}:${group_id} \
    --entrypoint "/ws/${include_path}/docker_entrypoint.sh" \
    $as_docker_name_tag /bin/bash -c "$@"

