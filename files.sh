#!/bin/bash
# @summary     Migrade files to a diferent server. Or just a simple backup
#
# @description ...
#              Copy files.conf.dist to files.conf and make your customizations
#
# @author      Bernardo Donadio <bcdonadio@alligo.com.br>
# @author      Emerson Rocha Luiz <emerson@alligo.com.br>
# @copyright   Copyright (C) 2016 Alligo Ltda. All rights reserved.

CONFIGURATION=${1:-"./files.conf"}

source $CONFIGURATION

DATETIME=$(date +"%Y-%m-%d-%H-%M")

# files_localdump
#
# $1 = BACKUP_FILES_DESTINY
# $2 = BACKUP_FILES_NAME
# $3 = BACKUP_FILES_EXCLUDE
# $4 = BACKUP_FILES_SOURCE
# $2 = BACKUP_FILES_NAME
files_localdump() {
  tar -cpzf ${BACKUP_FILES_DESTINY%+(/)}"/"$BACKUP_FILES_NAME"_"$DATETIME".tar.gz" $BACKUP_FILES_EXCLUDE $BACKUP_FILES_SOURCE
  #echo "@todo finish"
}

files_localrestore() {
  echo "@todo finish"
}

files_remotedump() {
  echo "@todo finish"
}

files_remoterestore() {
  echo "@todo finish"
}

move_local2remote() {
  echo "@todo finish"
}

move_remote2local() {
  echo "@todo finish"
}

# Command to just make a local copy
#tar -cpzf ${BACKUP_FILES_DESTINY%+(/)}"/"$BACKUP_FILES_NAME"_"$DATETIME".tar.gz" $BACKUP_FILES_EXCLUDE $BACKUP_FILES_SOURCE
files_localdump


echo "@todo finish me"