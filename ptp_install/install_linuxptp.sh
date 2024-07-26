#!/bin/bash

echo "[PTP] installing linuxptp application as Grandmaster for LLS-C1 configuration"
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
	systemctl daemon-reload
	systemctl enable ptp4l.service
	systemctl enable phc2sys.service
	echo "[Done] ptp installed and enabled successfully"
else 
	echo "ptp version not installed please install and try again"
fi
