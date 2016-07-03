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

ssh ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} "mysqldump -u $REMOTE_MYSQL_USER --password=$REMOTE_MYSQL_PASSWORD --host=$REMOTE_MYSQL_HOST --port=$REMOTE_MYSQL_PORT $REMOTE_MYSQL_DATABASE | gzip > ${REMOTE_MYSQL_DESTINY%+(/)}"/"$REMOTE_MYSQL_DATABASE"_"$DATETIME.sql.gz"

#copia de temp para alexandria
#scp root@site.com.br:/root/database.sql.tar.gz /home/centos/database.sql.tar.gz

# importa no alexandria
#zcat /home/centos/database.sql.tar.gz | mysql -u 'root' -p'SenhaServidorDestino' site_site