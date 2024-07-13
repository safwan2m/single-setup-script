#!/bin/bash

vf-setup-du(){
	source ./.env
	echo ----------------------- vf-setup --------------------------------
	echo [vf-setup] Creating 2 virtual functions
	echo 2 > /sys/bus/pci/devices/0000:$FH_NIC_BUS_ID/sriov_numvfs

	sleep 1
	echo [vf-setup] Loading igb_uio driver into kernel modules.
	if lsmod | grep -q uio; then
	    	echo "UIO module is loaded"
	else
	    	echo "UIO module is not loaded"
		modprobe uio
	fi
	if lsmod | grep -q igb_uio; then
	    	echo "IGB_UIO module is loaded"
	else
	    	echo "IGB_UIO module is not loaded"
		insmod /home/$USER/dpdk-kmods/linux/igb_uio/igb_uio.ko
	fi
	
	sleep 1
	echo [vf-setup] Setting MAC addresses for the virtual functions.
	ip link set $FH_INTERFACE vf 0 mac $FH_MAC vlan $FH_CU_VLAN trust on mtu $FH_MTU
	ip link set $FH_INTERFACE vf 0 spoofchk off
	sleep 1
	ip link set $FH_INTERFACE vf 1 mac $FH_MAC vlan $FH_CU_VLAN trust on mtu $FH_MTU
	ip link set $FH_INTERFACE vf 1 spoofchk off

	# Capture the output of the lspci command
	output=$(lspci | grep Eth | grep Virtual)
	
	# Extract the bus IDs using cut and store them in an array
	bus_ids=($(echo "$output" | cut -d' ' -f1))

	# Assign the bus IDs to individual variables if needed
	FH_NIC_VIRT1_BUS_ID=${bus_ids[0]}
	FH_NIC_VIRT2_BUS_ID=${bus_ids[1]}

	ip link set "$FH_INTERFACE"v0 down
	ip link set "$FH_INTERFACE"v1 down

	sleep 1

	echo The bus IDs of Virtual interfaces are $FH_NIC_VIRT1_BUS_ID $FH_NIC_VIRT2_BUS_ID
	
	echo [vf-setup] Binding virtual functions with igb_uio driver.
	dpdk-devbind.py -b igb_uio 0000:$FH_NIC_VIRT1_BUS_ID 0000:$FH_NIC_VIRT2_BUS_ID
	
	echo ----------------------- Done. ------------------------------------ 
}
