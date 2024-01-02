#!/bin/bash

echo "WTF include: into"

path=$(dirname "${BASH_SOURCE[0]}")
dockerfile=$path/Dockerfile

echo "WTF include: pre tag"

tag_long=$(sha256sum $dockerfile | awk '{ print $1 }')
tag=${tag_long::8}
as_docker_name="android_studio_coding_sandbox_docker"

echo "WTF include: $as_docker_name"

as_docker_name_tag="$as_docker_name:$tag"
echo "WTF include: $as_docker_name_tag"

android_docker_deps=$(awk -F"/projects/" '{print $1}'  <<< `pwd`)/android_studio_deps

echo "WTF include: $android_docker_deps"

docker images | grep $as_docker_name | grep $tag -q || DOCKER_BUILDIT=1 docker build -f $dockerfile -t $as_docker_name_tag .

echo "WTF include: image"
