#!/bin/bash
# @summary     Docker containers migration to diferent server
#
# @description ...
#              Copy docker.conf.dist to docker.conf and make your customizations
#
# @author      Bernardo Donadio <bcdonadio@alligo.com.br>
# @author      Emerson Rocha Luiz <emerson@alligo.com.br>
# @copyright   Copyright (C) 2016 Alligo Ltda. All rights reserved.

CONFIGURATION=${1:-"./docker.conf"}

source $CONFIGURATION

# For each container, stop, save a copy to a folder
# each param after fist one is a container name
#
# $1 = folder
# $@ = container1 container2 container3 ...
docker_localdump() {
  # NOT tested. Not finished
  FOLDER=$1

  for arg in "$@"
  do
    docker stop $arg
    docker export $arg > ${FOLDER}".tar"
  done
}

docker_localrestore() {
  # @todo finish
}

docker_remotedump() {
  # @todo finish
}

docker_remoterestore() {
  # @todo finish
}

move_local2remote() {
  # @todo finish this
}

move_remote2local() {
  # @todo finish this
}

echo "@todo finish me"