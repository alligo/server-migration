# faz dump no temporario
ssh root@site.com.br "mysqldump -u root -p'SenhaServidorTemporario' db_database2016 | gzip > /root/database.sql.tar.gz"

#copia de temp para alexandria
scp root@site.com.br:/root/database.sql.tar.gz /home/centos/database.sql.tar.gz

# importa no alexandria
zcat /home/centos/database.sql.tar.gz | mysql -u 'root' -p'SenhaServidorDestino' site_site