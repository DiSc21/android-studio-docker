#!/bin/bash

path=$(dirname "${BASH_SOURCE[0]}")
dockerfile=$path/Dockerfile

tag_long=$(sha256sum $dockerfile | awk '{ print $1 }')
tag=${tag_long::8}
name=android_coding_sandbox_docker

dockername="$name:$tag"
android_docker_deps=$(awk -F"/projects/" '{print $1}'  <<< `pwd`)/android_studio_deps

docker images | grep $name | grep $tag -q || DOCKER_BUILDIT=1 docker build -f $dockerfile -t $dockername .

