#!/bin/bash
com() {
    ports_USB=$(ls /dev/ttyUSB*)
    ports="$ports_USB $ports_ACM"
    datename=$(date +%Y%m%d-%H%M%S)
    select port in $ports
	do
        if [ "$port" ]; then
            echo "You select the choice '$port'"
            minicom -D "$port" -C ~/serial_log/"$datename".log "$@"
            break
        else
            echo "Invaild selection"
        fi
    done
}
