#!/bin/bash
# @summary     MySQL/MariaDB database migration to diferent server
#
# @description This script make full MySQL/MariaDB dump and copy to local server
#              and can just be used as make a local copy or migrate to local
#              database server
#              Copy mysql-server-migration.conf.dist to
#              mysql-server-migration.conf and make your customizations first
#
# @author      Bernardo Donadio <bcdonadio@alligo.com.br>
# @author      Emerson Rocha Luiz <emerson@alligo.com.br>
# @copyright   Public Domain

source ./mysql-server-migration.conf
#if [ `source ./mysql-server-migration.conf` != "0" ]; then
#   echo "mysql-server-migration.conf not found. Aborting";
#   exit;
#fi

DATETIME=$(date +"%Y-%m-%d-%H-%M")

echo "REMOTE: mysqldump $REMOTE_MYSQL_DATABASE to ${REMOTE_MYSQL_DESTINY%+(/)}"/"$REMOTE_MYSQL_DATABASE"_"$DATETIME.sql.gz ..."
ssh ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} "mysqldump -u $REMOTE_MYSQL_USER --password=$REMOTE_MYSQL_PASSWORD --host=$REMOTE_MYSQL_HOST --port=$REMOTE_MYSQL_PORT $REMOTE_MYSQL_DATABASE | gzip > ${REMOTE_MYSQL_DESTINY%+(/)}"/"$REMOTE_MYSQL_DATABASE"_"$DATETIME.sql.gz"

echo "REMOTE TO LOCAL: copy ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:${REMOTE_MYSQL_DESTINY%+(/)}"/"$REMOTE_MYSQL_DATABASE"_"$DATETIME.sql.gz to ${LOCAL_MYSQL_DESTINY%+(/)}"/"$LOCAL_MYSQL_DATABASE"_"$DATETIME.sql.gz"
scp ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:${REMOTE_MYSQL_DESTINY%+(/)}"/"$REMOTE_MYSQL_DATABASE"_"$DATETIME.sql.gz ${LOCAL_MYSQL_DESTINY%+(/)}"/"$LOCAL_MYSQL_DATABASE"_"$DATETIME.sql.gz

if [ $BACKUP_ONLY -eq 1 ]; then
   echo "Backup only method. Nothing more to do";
   exit;
fi

echo "LOCAL: importing $LOCAL_MYSQL_DATABASE ..."
zcat ${LOCAL_MYSQL_DESTINY%+(/)}"/"$LOCAL_MYSQL_DATABASE"_"$DATETIME.sql.gz | mysql -u $LOCAL_MYSQL_USER --password=$LOCAL_MYSQL_PASSWORD --host=$LOCAL_MYSQL_HOST --port=$LOCAL_MYSQL_PORT $LOCAL_MYSQL_DATABASE