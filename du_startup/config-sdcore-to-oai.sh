#!/bin/bash

routing_to_oaicore(){

	echo "Removing old routes"
	
	sudo ip route del 192.168.252.0/24
	
	sleep 1
	
	echo "Adding new routed for OAI-Core"
	
	sudo ip route add 192.168.70.128/26 via 10.33.42.112
	sleep 1
	
	route -n

	echo "Config Complete !!"

}
