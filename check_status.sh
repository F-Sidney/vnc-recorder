#!/bin/bash

is_recorder_running() {
  pgrep -f "vnc-recorder-linux-amd64 --host 127.0.0.1">/dev/null 2>&1
}

current_date=$(date +"%m%d%H%M%S")
pcname="test"

if is_recorder_running; then
  echo "vnc recorder for ${pcname} script Running OK!"
else
  echo "vnc recorder for ${pcname} script is not Running, start it now!"
  /home/code/vnc-recorder/vnc-recorder-linux-amd64 --host 127.0.0.1 --port 5900 --password XXXXXX --framerate 5 --crf 10 --outfile /tmp/${pcname}_${current_date}_ >> "/var/log/${pcname}_vnc_${current_date}.log" 2>> "/var/log/${pcname}_vnc_${current_date}.err.log" &
    if [ $? -eq 0 ]; then
        echo "vnc recorder for ${pcname}. Output redirected to folder /var/log/"
    else
        echo "Error: Failed to start vnc recorder. Check logs for more details."
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Error: Failed to start vnc recorder." >>"/var/log/vnc_script_errors.log"
    fi
fi
