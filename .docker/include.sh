#!/bin/bash

include_path=$(dirname "${BASH_SOURCE[0]}")
echo ${include_path}
dockerfile=$include_path/Dockerfile

tag_long=$(sha256sum $dockerfile | awk '{ print $1 }')
tag=${tag_long::8}

as_docker_name="android_studio_coding_sandbox_docker"
as_docker_name_tag="$as_docker_name:$tag"

android_docker_home_volume="$include_path/../docker_home_volume"

user_id=`id -u`
user_name=`id -nu`
group_id=`id -g`
group_name=`id -ng`

docker_build_cmd="docker build -f $dockerfile -t $as_docker_name_tag"
docker_build_cmd="$docker_build_cmd --build-arg ARG_USER_ID=$user_id --build-arg ARG_GROUP_ID=$group_id"
docker_build_cmd="$docker_build_cmd --build-arg ARG_USER_NAME=$user_name --build-arg ARG_GROUP_NAME=$group_name"

docker images | grep $as_docker_name | grep $tag -q || DOCKER_BUILDIT=1 $docker_build_cmd .

