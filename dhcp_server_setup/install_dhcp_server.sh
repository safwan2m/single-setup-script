#!/bin/bash

source .env

apt install isc-dhcp-server
cp dhcpd.conf /etc/dhcp/dhcpd.conf
cp isc-dhcp-server /etc/default/isc-dhcp-server

sed -i "s/interface_name/$INTERFACE/g" "$FILE_PATH"

systemctl restart isc-dhcp-server
