#!/bin/bash

echo "Starting setup-du.service to setup the Virtual functions and start all the services"

source /usr/sbin/setup-du/vf-setup-du.sh
source /usr/sbin/setup-du/config-oai-to-sdcore.sh
source /usr/sbin/setup-du/config-sdcore-to-oai.sh
source /usr/sbin/setup-du/.env

# Define the service name
SERVICE_LIST="ptp4l 
		phc2sys 
		isc-dhcp-server 
		tuned"
vf-setup-du

ALL_RUNNING=true

while [ "$ALL_RUNNING" = true ]
do
	ALL_RUNNING=false
	for SERVICE_NAME in $SERVICE_LIST
	do
    		# Check if the service is running
    		if systemctl is-active --quiet "$SERVICE_NAME"; then
        		echo "$SERVICE_NAME is running."
    		else
        		echo "$SERVICE_NAME is not running. Starting $SERVICE_NAME..."
        		# Start the service
        		systemctl start "$SERVICE_NAME"

        		# Verify if the service started successfully
        		if systemctl is-active --quiet "$SERVICE_NAME"; then
            			echo "$SERVICE_NAME started successfully."
        		else
            			echo "Failed to start $SERVICE_NAME."
        		fi
			ALL_RUNNING=true
    		fi
	done
	sleep 10;
	echo;
done

if [ "$CORE" = 'OAI' ]; then
	routing_to_oaicore
elif [ "$CORE" = 'SDCORE' ]; then
	routing_to_sdcore
else
	routing_to_sdcore
fi

echo "All services are running! Exiting setup-du.service"
