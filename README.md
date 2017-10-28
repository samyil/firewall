# Simple Iptables Firewall

~$ sudo apt-get install git

~$ git clone https://github.com/samyil/firewall.git

~$ chmod 755 firewall/firewall.sh

~$ sudo firewall/firewall.sh

Usage: firewall/firewall.sh {start|stop|restart|status}

-----------------------------------------------------------

# Enable rc.local on systemd

sudo nano /etc/systemd/system/rc-local.service

[Unit]
Description=/etc/rc.local Compatibility
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target

--------------------------------------------------------

sudo touch /etc/rc.local
sudo chmod 755 /etc/rc.local

--------------------------------------------------------

sudo nano /etc/rc.local

#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

exit 0

-----------------------------------------------------

sudo systemctl enable rc-local
sudo systemctl start rc-local.service
sudo systemctl status rc-local.service

-----------------------------------------------------

sudo nano /etc/rc.local
/home/samyil/firewall/firewall.sh start
