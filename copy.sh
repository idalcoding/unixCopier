#!/bin/bash
echo " "
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

echo "Removing old duplicates from ${MY_DIR}..."

# Finding all files with duplicate names
files=$(find ${MY_DIR} -type f -printf "%f\n" | sort | uniq -d)

for file in $files; do
    # Finding the latest version of the file
    latest=$(find ${MY_DIR} -type f -name ${file} -printf "%T@ %p\n" | sort -n | tail -1 | awk '{print $2}')
    # Removing all other versions of the file
    find ${MY_DIR} -type f -name ${file} ! -wholename ${latest} -delete
done

echo "Looking for NEWER files FIRST....."

echo "Copying your files to ${DEST}"
echo "This might take a while"

# Spinner function that works across all shells
spin()
{
    local -a pid
    local -a spin
    spin=( "-" "\\" "|" "/" )
    printf " [%c]  " "${spin[0]}"
    for i in "${spin[@]}"; do
        pid[0]=$!
        printf "\b\b\b\b[%c]  " "$i"
        sleep .1
    done
}

# Starting the spinner
spin &

cp -r ${MY_DIR} ${DEST}
echo "-------------------------"

echo "Copying complete!"
