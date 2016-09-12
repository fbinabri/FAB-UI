#!/bin/bash

IP=${1}

if [ -z "$IP" ] ; then
	echo "Missing ip address"
	exit
fi

cat <<EOF> /etc/network/interfaces

# interfaces(5) file used by ifup(8) and ifdown(8)

# Please note that this file is written to be used with dhcpcd
# For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto lo
iface lo inet loopback
allow-hotplug eth0
auto eth0
iface eth0 inet static
address $IP
netmask 255.255.255.0

allow-hotplug wlan0
auto wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

allow-hotplug wlan1
iface wlan1 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

EOF
sudo /etc/init.d/networking reload