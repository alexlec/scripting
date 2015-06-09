#!/bin/bash
#
# COPYRIGHT:
# (c) 2012 Alexis Lecomte
#
# DESCRIPTION:
# A simple BASH script to do nightly backups 
#
# USAGE:
# safeguard.sh NAME
#


###############################################################
### PREPARE: ARGUMENTS
###############################################################

NAME	  = $1


###############################################################
### PREPARE: SYSTEM VARS
###############################################################

FTP	  = "$(which ftp)"
MYSQL	  = "$(which mysql)"
MYSQLDUMP = "$(which mysqldump)"
GZIP	  = "$(which gzip)"
NOW	  = $(date +"%Y-%m-%d")
BACKUP	  = /tmp/backup.$$


###############################################################
### PREPARE: PARAMETERS
###############################################################

ftp_site  = "subdomain.domain.ext"
username  = "myDropFtpLogin"
passwd    = "MyDropFtpPasswd"
backupdir = $HOME
filename  = "$NAME(date '+%F-%H%M').tar.gz"


###############################################################
### PERFORM: INIT
###############################################################

clear

echo "╔===================================================╗"
echo "║ Saving process for $NAME begin at `date`          ║"
echo "╚===================================================╝"


###############################################################
### PERFORM: LOCAL WORK
###############################################################

echo "Creating a backup file $filename of $backupdir."

# Make a tar gzipped backup file
tar -cvzf  "$filename" "$backupdir"


###############################################################
### PERFORM: EXTERNAL COPY
###############################################################

ftp -in <<EOF
open $ftp_site
user $username $passwd
cd backup/web/
bin
put $filename 
close 
bye
EOF