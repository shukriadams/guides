#!/bin/bash

set -e

# takes three arguments :
# 1 - path to backup from
# 2 - path to backup to
# 3 - name of backup job, used for logging
function backup(){
    SRC_PATH=$1
    TARGET_PATH=$2
    NAME=$3

    cd $SRC_PATH
    # gets count of files in source directory
    FILES=$(ls | wc -l)
    # gets count of child dirs in source directory
    DIRECTORIES=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)
    LOG="/home/pi/${NAME}-rsync-cron.log"

    # If source directory is empty, do not backup, as this will wipe out everything in target.
    # This can happen when the source mount fails.
    if [ $FILES -eq 0 ] && [ $DIRECTORIES -eq 0 ]; then
        echo "nothing to backup in ${SRC_PATH}, skipping" | tee $LOG
    else
        rsync -avh "${SRC_PATH}/" "${TARGET_PATH}" --delete | tee $LOG
    fi
}

# DIRECTORIES TO BACKUP
# Example :
#
# backup "/home/pi/test1" "/home/pi/test2" "thetest"

backup "/home/pi/test1" "/home/pi/test2" "thetest"
