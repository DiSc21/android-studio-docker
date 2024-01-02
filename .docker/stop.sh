#!/bin/bash

source $(dirname "${BASH_SOURCE[0]}")/include.sh

if docker ps | grep -q $docker_name
then
  docker stop $docker_name
else
  echo "docker $docker_name not running"
fi

