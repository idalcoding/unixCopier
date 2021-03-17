#!/bin/bash
# Author : Webster
# Copyright (c) 2021
# Script follows here:
MY_DIR=$1

# MY_DIR="/home/webster/Desktop/test/"
# DEST="/home/webster/Desktop/trial/"

echo "------Starting check-------"
echo "Enter directort to find files"
read MY_DIR
echo "Now reading contents in "${MY_DIR}/""*
echo "---------------"
echo "Enter destination folder to copy files"
read DEST
echo "Copying files to "${DEST}""
FILEEXT="*"
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

echo "========NOTICE========"
echo "Looking for newer files first....."
echo "           "
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
echo "                    "
echo "Copying your files....."
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
echo "----------BYE---------"
