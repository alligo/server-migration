#!/bin/bash
# @summary     MySQL/MariaDB database migration to diferent server
#
# @description ...
#
# @author      Bernardo Donadio <bcdonadio@alligo.com.br>
# @author      Emerson Rocha Luiz <emerson@alligo.com.br>
# @copyright   Public Domain

# Load configuration
source ./mysql-server-migration.conf

DATETIME=$(date +"%Y-%m-%d-%H-%M")

echo "REMOTE: mysqldump $REMOTE_MYSQL_DATABASE to ${REMOTE_MYSQL_DESTINY%+(/)}"/"$REMOTE_MYSQL_DATABASE"_"$DATETIME.sql.gz ..."
ssh ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} "mysqldump -u $REMOTE_MYSQL_USER --password=$REMOTE_MYSQL_PASSWORD --host=$REMOTE_MYSQL_HOST --port=$REMOTE_MYSQL_PORT $REMOTE_MYSQL_DATABASE | gzip > ${REMOTE_MYSQL_DESTINY%+(/)}"/"$REMOTE_MYSQL_DATABASE"_"$DATETIME.sql.gz"

echo "REMOTE TO LOCAL: copy ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:${REMOTE_MYSQL_DESTINY%+(/)}"/"$REMOTE_MYSQL_DATABASE"_"$DATETIME.sql.gz to ${LOCAL_MYSQL_DESTINY%+(/)}"/"$LOCAL_MYSQL_DATABASE"_"$DATETIME.sql.gz"
scp ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:${REMOTE_MYSQL_DESTINY%+(/)}"/"$REMOTE_MYSQL_DATABASE"_"$DATETIME.sql.gz ${LOCAL_MYSQL_DESTINY%+(/)}"/"$LOCAL_MYSQL_DATABASE"_"$DATETIME.sql.gz

echo "LOCAL: importing $LOCAL_MYSQL_DATABASE ..."
zcat ${LOCAL_MYSQL_DESTINY%+(/)}"/"$LOCAL_MYSQL_DATABASE"_"$DATETIME.sql.gz | mysql -u $LOCAL_MYSQL_USER --password=$LOCAL_MYSQL_PASSWORD --host=$LOCAL_MYSQL_HOST --port=$LOCAL_MYSQL_PORT $LOCAL_MYSQL_DATABASE