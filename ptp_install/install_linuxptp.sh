#!/bin/bash

source .env

apt install linuxptp

install_version=$(ptp4l -v)

echo $install_version

if [ "$install_version" = "3.1.1" ]; then
	echo "linuxptp version '$install_version' installed successfully"
	cp *.service /lib/systemd/system/.
	cp iisc_config.cfg /etc/linuxptp/.
	sed -i "s/interface_name/$PTP_INTERFACE/g" "$PTP4L_FILE_PATH"
	sed -i "s/interface_name/$PTP_INTERFACE/g" "$PHC2SYS_FILE_PATH"
	echo "ptp installed successfully"
else 
	echo "ptp version not installed please install and try again"
fi
