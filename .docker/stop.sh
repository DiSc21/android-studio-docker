#!/bin/bash

source $(dirname "${BASH_SOURCE[0]}")/include.sh

if docker ps | grep -q $as_docker_name
then
  docker stop $as_docker_name
else
  echo "docker $as_docker_name not running"
fi

