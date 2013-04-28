#!/bin/bash
FS_PATH=/media/fs
if [[ -z "$1" ]]
then 
        echo "you must provide hostname, wifi_ssid and wifi_pass"
        exit 1
else
        if [[ -z "$2" ]]
        then 
                echo "you must provide hostname, wifi_ssid and wifi_pass"
        		exit 1
        else
                if [[ -z "$3" ]]
		        then 
		                echo "you must provide hostname, wifi_ssid and wifi_pass"
		       			exit 1
		        else
		        		echo "/**********************************"/
		                echo " * device settings:"
		                echo " *       hostname : "$1
		                echo " *       wifi_ssid: "$2
		                echo " *       wifi_pass: "$3
						./set_hostname.sh $1
						./set_interfaces.sh $2 $3
						./set_init.sh
						./set_nfs.sh
						./set_usbautomount.sh
		        fi
        fi
fi
