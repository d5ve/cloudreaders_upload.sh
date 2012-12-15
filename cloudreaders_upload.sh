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
        if [[ "$COMIC" =~ , ]]; then
            # Filepath contains a , (comma) which currently prevents curl from
            # uploading it.
            SAFE_COMIC=/tmp/$(basename "$COMIC" | sed 's/,/ /g; s/  / /g')
            ln -s "$COMIC" "$SAFE_COMIC"
            echo "Filename '$COMIC' contains a comma, so uploading as '$SAFE_COMIC'"
            curl --silent --show-error --form "datafile=@$SAFE_COMIC" http://$HOST:$PORT/post --output /dev/null
            rm "$SAFE_COMIC"
        else
            echo "Uploading '$COMIC'"
            curl --silent --show-error --form "datafile=@$COMIC" http://$HOST:$PORT/post --output /dev/null
        fi
        shift
    else
        break
    fi
done

exit;
