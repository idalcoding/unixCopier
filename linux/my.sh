#!/bin/bash
# Author : Webster Avosa

echo "------Starting check-------"
echo "Enter MY_DIR to find files"
read MY_DIR

if [ -d "$MY_DIR" ]; then
    echo "Checking files and directories in ${MY_DIR}..."
else
    echo "Error: ${MY_DIR} not found. Exiting."
    exit
fi

echo "Enter destination folder to copy files"
read DEST

if [ -d "$DEST" ]; then
    echo "Checking files and directories in ${DEST}..."
else
    echo "Error: ${DEST} not found. Exiting."
    exit
fi

echo "Removing duplicates from ${MY_DIR}..."
find ${MY_DIR} -type f -exec md5sum {} + | sort | uniq -w 32 -d --all-repeated=separate | awk '{print $2}' | xargs -I{} rm -f {}

echo "Looking for NEWER files FIRST....."

echo "Copying your files to ${DEST}"
echo "This might take a while"

function spinner() {
    sleep 7 &
    PID=$!
    i=1
    sp="/-\|"
    echo -n ' '
    while [ -d /proc/$PID ]; do 
        printf "\b${sp:i++%${#sp}:1}"
    done
}

spinner

cp -r ${MY_DIR} ${DEST}
echo "-------------------------"

echo "Copying complete!"

