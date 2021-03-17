# !/bin/bash
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

echo "========NOTICE========"
echo "Looking for newer files first....."
# Adding some spinner 
function spine(){
    i=1
    sp="/-\|"
    echo -n ' '
    while [ $i -le 5 ]
    do
        printf "\b${sp:i++%${#sp}:1}"
    done
}
spine

echo "                    "
echo "                    "
NEWEST=`ls -tr1d "${MY_DIR}/"*.${FILEEXT} 2>/dev/null | tail -1`

if [ -z "${NEWEST}" ] ; then
    echo "No newest file to copy"
    exit 1
elif [ -d "${NEWEST}" ] ; then
    echo "The most recent entry is a directory"
    exit 1
else
    echo "Found!!!!Copying ${NEWEST}"
    cp -p "${NEWEST}" "${DEST}"
fi
echo "                    "
echo "Be patient as I copy your files....."
echo "                    "
echo "This might take a while"

cp -r ${MY_DIR} ${DEST}
echo "---------------------"
echo -ne '#####                     (1%)\r'
sleep 1
echo -ne '########                  (11%)\r'
sleep 1
echo -ne '###########               (33%)\r'
sleep 1
echo -ne '#################         (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'
echo "-----------------------"
echo "SUCCESSFULLY COPIED FIlES"
echo "-----------------------"
echo "----------BYE---------"