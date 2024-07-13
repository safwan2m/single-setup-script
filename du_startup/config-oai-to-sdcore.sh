#!/bin/bash

routing_to_sdcore(){
	echo "Removing old routes"
	
	sudo ip route del 192.168.70.128/26
	
	sleep 1
	
	echo "Adding new routed for SD-Core"
	
	sudo ip route add 192.168.252.0/24 via 10.33.42.197
	sleep 1
	
	route -n

	echo "Config Complete !!"
}
