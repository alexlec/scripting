#!/bin/bash
SERVER_DIR="/var/www/vhosts/site.org"
DATE=$(date +"%d-%m-%Y")
BACKUP_DIR="/backups/$DATE"
NAME="full-$DATE"

MYSQLUSER="admin"
MYSQLPASS="pass"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"

mkdir -p $BACKUP_DIR
tar -zcvf $BACKUP_DIR/$NAME.tar.gz $SERVER_DIR
$MYSQLDUMP -u $MYSQLUSER -p$MYSQLPASS --all-databases | $GZIP -c9 > $BACKUP_DIR/$NAME.sql
find /backup/ -mtime +31 -exec rm -rf {} \;