#!/bin/bash

function UPDATE {

	echo Running Script...
	sudo apt update && sudo apt upgrade -y | tail -n 1 | gawk '{print $1;}' > file.txt
	LOG_FILE=/home/bob/.logs/sysupdate.log
	STRING=$(<file.txt)

	if [[ "0" == *"$STRING"* ]]; then
		STATUS="unchanged"
	elif [[ "Processing" == *"$STRING"* ]]; then
		STATUS="updated"
	else
		STATUS="failed"
	fi
	
	echo $STRING	
	echo $STATUS
	LOG="Update ran on $(date). Status: $STATUS"
	if [ -f "$LOG_FILE" ]; then
		echo $LOG >> $LOG_FILE
	elif [ ! -f "/home/bob/.logs/" ]; then
		mkdir /home/bob/.logs/
		echo #CHECK /var/log/apt/history.log FOR MORE INFO
		echo $LOG > $LOG_FILE
	fi
}
UPDATE
