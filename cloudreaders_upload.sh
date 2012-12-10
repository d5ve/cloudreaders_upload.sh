#!/bin/bash

# Upload a CBR/CBZ/ZIP file to the CloudReaders iPhone/iPad app. 
# 
# Requires the curl commandline tool
# 
# First turn on the WiFi upload facility, and note the host/IP and the port
# number. Make sure HOST and PORT are set correctly below.
#
# Then run the script with something like: 
#   cloudreaders_upload.sh *.cbr 
#


if [ "0$1" = "0" ]; then
    echo "USAGE $0 <file.cbr> [<file.cbr>...]"
    exit
fi

HOST="192.168.0.8"
PORT="8080"

while true; do
    if [ "$1" ]; then
        COMIC="$1"
        echo "Uploading '$COMIC'"
        curl --silent --show-error -F "datafile=@$COMIC" http://$HOST:$PORT/post --output /dev/null
        shift
    else
        break
    fi
done

exit;
