#!/bin/sh
# Kopia zapasowa dodatku w katalogu backup
DATA=`date +%Y%m%d_%H_%M_%S`
DIR=`basename "$PWD"`
NAME="${DIR}_${DATA}"
#tar -zcf ../backup/$NAME.tgz ./ --exclude='./backup_addon.sh'
zip -r ../../../backup/$NAME.zip ./ -x ./backup_addon.sh