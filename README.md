# octoprint docker

docker run -d -p 5000 --device=/dev/ttyUSB0 --name=my_container_name mrwyss/octoprint-docker



QNAP Notes
you can run/start the package through the container station. Make sure that ups_yec (a UPS Service) is not running. It makes interferes with USB Devices. To do so:

1. Find system config drive
	``` 
	echo "Your autorun.sh needs to be placed in: $(getcfg system "system device")6"
	```
2. Mount the config dir
	```
	mount -t ext2 $(getcfg system "system device")6 /tmp/config
	```
3. create a autorun.sh file
	```
	vi /tmp/config/autorun.sh
	```
Content: 
	```
	#!/bin/sh
	# remove wrong ups yec assignment and generate dummy ups_yec executable
	/sbin/daemon_mgr ups_yec stop "/sbin/ups_yec &"
	rm /tmp/ups_temp
	echo '#!/bin/sh' > /sbin/ups_yec
	echo 'while true' >> /sbin/ups_yec
	echo 'do' >> /sbin/ups_yec
	echo 'sleep 10' >> /sbin/ups_yec
	echo 'done' >> /sbin/ups_yec
	```
4. Add execute rights
	``` 
	chmod +x /tmp/config/autorun.sh
	```
5. unmount the config drive
	``` 
	umount /tmp/config
	```