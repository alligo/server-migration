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
}


REMOTE_FULLPATH=$REMOTE_MONGO_DESTINY"/"${DATETIME}
echo "REMOTE: mongodump to $REMOTE_FULLPATH folder"
#ssh ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} 
#mongodump --host $REMOTE_MONGO_HOST --port $REMOTE_MONGO_PORT --out $REMOTE_MONGO_DESTINY"/"${DATETIME}
mongo_localdump $REMOTE_MONGO_HOST $REMOTE_MONGO_PORT $REMOTE_MONGO_DESTINY"/"${DATETIME}