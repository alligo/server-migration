#!/bin/bash
# @summary     MongoDB database migration to diferent server
#
# @description This script make full MongoDB dump and copy to local server
#              and can just be used as make a local copy or migrate to local
#              database server
#              Copy mongo.conf.dist to mongo.conf and make your customizations
#
# @author      Bernardo Donadio <bcdonadio@alligo.com.br>
# @author      Emerson Rocha Luiz <emerson@alligo.com.br>
# @copyright   Copyright (C) 2016 Alligo Ltda. All rights reserved.

CONFIGURATION=${1:-"./mongodb.conf"}

source $CONFIGURATION
#if [ `source ./mysql-server-migration.conf` != "0" ]; then
#   echo "mysql-server-migration.conf not found. Aborting";
#   exit;
#fi

DATETIME=$(date +"%Y-%m-%d-%H-%M")

# mongo_localdump:
#
# $1 = host
# $2 = port
# $3 = backupfolder
mongo_localdump() {
  mongodump --host $1 --port $2 --out $3
  tar -zcf ${3%/}".tar.gz" -C $3 .
  rm -rf $3
  # todo: maybe just do not remove temporary folder?
  #       problem is that it could do not remove deleted content
  # todo: use temp folder and just use destiny to tar.gz file
}

mongo_localrestore() {
  # @todo finish this
}

# mongo_remotedump:
# 
# $1 = ssh_user
# $2 = ssh_host | ssh_host:port
# $3 = mongoport
# $4 = backupfolder (no timestamp for temporary folder)
mongo_remotedump() {
  # Function not tested
  DATETIME=$(date +"%Y-%m-%d-%H-%M")
  ssh ${1}@${2} "mongodump --port $3 --out $4"
  ssh ${1}@${2} "tar -zcf ${4%/}${DATETIME}".tar.gz" -C $4 ."
  #Note: this function will not rm -rf directory. Just to avoid problems
}

mongo_remoterestore() {
  # @todo finish this
}

move_local2remote() {
  # @todo finish this
}

move_remote2local() {
  # @todo finish this
}


REMOTE_FULLPATH=$REMOTE_MONGO_DESTINY"/"${DATETIME}
echo "REMOTE: mongodump to $REMOTE_FULLPATH folder"
#ssh ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} 
#mongodump --host $REMOTE_MONGO_HOST --port $REMOTE_MONGO_PORT --out $REMOTE_MONGO_DESTINY"/"${DATETIME}
mongo_localdump $REMOTE_MONGO_HOST $REMOTE_MONGO_PORT $REMOTE_MONGO_DESTINY"/"${DATETIME}