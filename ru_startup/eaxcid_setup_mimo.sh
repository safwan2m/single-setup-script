#!/usr/bin/expect -f
#start the ssh session
set username "root"
set password "vvdn"
set host "192.168.4.25"
set remote_command "xml_parser eaxcid_modify_mimo.xml\r"
spawn ssh $username@$host
#handle the password prompt
expect "password:"
send "$password\r"
#wait for the shell prompt
expect "$ "
#send the command for execution
send "$remote_command"
#wait for the command to complete and the shell prompt to return
expect "$ "
#print the result of the command
expect eof
