#!/bin/bash
# Author : Webster Avosa
# Copyright (c) 2021
# Script follows here:

echo "------Starting check-------"
echo "Enter directory to find files"
read MY_DIR
echo "Now reading contents in "${MY_DIR}/""*
echo "---------------"
echo "Looping files in "${MY_DIR}""
function check(){
    sleep 7 &
    PID=$!
    i=1
    sp="/-\|"
    echo -n ' '
    while [ -d /proc/$PID ]
    do 
        printf "\b${sp:i++%${#sp}:1}"
    done
}
check

# Add an empty space on terminal 
echo " "
echo "Enter destination folder to copy files"
read DEST
FILEEXT="*"

# SECTION COMMENTS 
echo "========NOTICE========"
# Add an empty space on terminal 
echo " "
echo "Looking for NEWER files FIRST....."
echo "  
         "
# Adding some spinner 
function spine(){
    echo -ne '#####                     (1%)\r'
    sleep 1
    echo -ne '######                    (10%)\r'
    sleep 1
    echo -ne '########                  (25%)\r'
    sleep 1
    echo -ne '##########                (45%)\r'
    sleep 1
    echo -ne '############              (55%)\r'
    sleep 1
    echo -ne '##############            (75%)\r'
    sleep 1
    echo -ne '#################         (85%)\r'
    sleep 1
    echo -ne '###################       (99%)\r'
    sleep 1
    echo -ne '#######################   (100%)\r'
    echo -ne '\n'   
}
spine

echo "                    "
echo "                    "

# Checking for newest file/directory 
# Making sure to pick latest files 
NEWEST=`ls -tr1d "${MY_DIR}/"*.${FILEEXT} 2>/dev/null | tail -1`

if [ -z "${NEWEST}" ] ; then
    echo "No newest file to copy"
    exit 1
elif [ -d "${NEWEST}" ] ; then
    echo "The most recent entry is a directory"
    exit 1
else
    echo "FOUND!!!!Copying ${NEWEST}"
    cp -p "${NEWEST}" "${DEST}"
fi
echo "  "

# Some spinner to display file copying                 
echo "Copying your files to "${DEST}""
function copyFiles(){
    sleep 7 &
    PID=$!
    i=1
    sp="/-\|"
    echo -n ' '
    while [ -d /proc/$PID ]
    do 
        printf "\b${sp:i++%${#sp}:1}"
    done
}
copyFiles
echo "                    "
echo "This might take a while"

cp -r ${MY_DIR} ${DEST}
echo "-------------------------"

# Added yet another spinner 
function yetAnotherSpinner(){
    echo -ne '##                        (1%)\r'
    sleep 1
    echo -ne '###                       (5%)\r'
    sleep 1
    echo -ne '####                      (10%)\r'
    sleep 1
    echo -ne '######                    (15%)\r'
    sleep 1
    echo -ne '#######                   (20%)\r'
    sleep 1
    echo -ne '########                  (25%)\r'
    sleep 1
    echo -ne '#########                 (30%)\r'
    sleep 1
    echo -ne '##########                (35%)\r'
    sleep 1
    echo -ne '###########               (40%)\r'
    sleep 1
    echo -ne '############              (45%)\r'
    sleep 1
    echo -ne '#############             (50%)\r'
    sleep 1
    echo -ne '##############            (55%)\r'
    sleep 1
    echo -ne '###############           (60%)\r'
    sleep 1
    echo -ne '################          (65%)\r'
    sleep 1
    echo -ne '#################         (70%)\r'
    sleep 1
    echo -ne '##################        (75%)\r'
    sleep 1
    echo -ne '###################       (80%)\r'
    sleep 1
    echo -ne '####################      (85%)\r'
    sleep 1
    echo -ne '#####################     (90%)\r'
    sleep 1
    echo -ne '######################    (99%)\r'
    sleep 1
    echo -ne '#######################   (100%)\r'
    echo -ne '\n'    
}
yetAnotherSpinner
echo "-----------------------"
echo "SUCCESSFULLY COPIED FIlES"
echo "-----------------------"
echo "----------Now removing duplicates---------"

FILES_IN_DEST=${DEST}
if [[ -z "$FILES_IN_DEST" ]]; then
    echo "Error: files dir is undefined"
    exit;
fi

find $FILES_IN_DEST -type f -exec openssl sha1 \{\} \; > /tmp/list.txt


count=-1
total=0
for listOfFileDuplicates in `cat /tmp/list.txt | sed 's/SHA1(\(.*\))\= \(.*\)$/\2 \1/' | awk '{print $1}' | sort | uniq -c | sort -nr`
do
    if [[ $count == -1 ]]
    then
        count=$listOfFileDuplicates
    else 
        hash=$listOfFileDuplicates
        if [[ $count == 1 ]]
        then
            break
        fi
        for file in `grep $hash /tmp/list.txt | sed 's/SHA1(\(.*\))\= \(.*\)$/\2 \1/' | awk '{print $2}'`
        do
            if [[ $count > 1 ]]
            then
                echo "Moving $file to trash"
                count=$((count-1))
            fi
        done
        total=`expr $total + $count`
        count=-1
    fi
done

echo "Deleted $total files"
echo
