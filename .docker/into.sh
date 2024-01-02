#!/bin/bash

source $(dirname "${BASH_SOURCE[0]}")/include.sh

if docker ps | grep -q $as_docker_name
then
  echo "docker already up and running"
  docker exec -it $as_docker_name /bin/bash
else
  docker run -it --rm --name $as_docker_name \
      --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
      --device=/dev/kvm \
      --device /dev/nvidia0:/dev/nvidia0 \
      --device /dev/nvidiactl:/dev/nvidiactl \
      --device /dev/nvidia-uvm:/dev/nvidia-uvm \
      --net=host \
      --env="DISPLAY" \
      -v `pwd`:/ws/ \
      -v ${android_docker_deps}:/root/android_docker_deps/ \
      $as_docker_name_tag bash
fi

