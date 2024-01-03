#!/bin/bash

source $(dirname "${BASH_SOURCE[0]}")/include.sh

if docker ps | grep -q $as_docker_name
then
  echo "docker already up and running"
  docker exec -it $as_docker_name /bin/bash
else
  docker run --rm -it --name $as_docker_name \
      --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
      --device=/dev/kvm \
      --device /dev/nvidia0:/dev/nvidia0 \
      --device /dev/nvidiactl:/dev/nvidiactl \
      --device /dev/nvidia-uvm:/dev/nvidia-uvm \
      --net=host \
      --env="DISPLAY" \
      --entrypoint "${include_path}/docker_entrypoint.sh" \
      -v `pwd`:/ws/ \
      -v ${android_docker_home_volume}:/home/${user_name} \
      -u ${user_id}:${group_id} \
      $as_docker_name_tag /bin/bash
fi

