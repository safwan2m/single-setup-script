#!/bin/bash
netopeer2-cli <<END
connect --ssh --host 192.168.4.25 --login root
edit-config --target running --config=activate-carrier.xml --defop replace 
get-config --source running
disconnect
exit
END
sudo systemctl start tuned.service
echo ""
exit 0
