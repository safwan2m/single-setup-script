install: setup-du
	cp *.sh /usr/sbin/setup-du/.
	cp .env /usr/sbin/setup-du/.
	cp setup-du.service /etc/systemd/system/.
	systemctl daemon-reload
	systemctl restart setup-du.service
	systemctl enable setup-du.service
setup-du:
	mkdir -p /usr/sbin/setup-du
