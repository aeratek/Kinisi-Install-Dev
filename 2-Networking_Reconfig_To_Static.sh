#!/bin/sh -x
# This bash script configures a static IP address
# It does no error checking at the present time

echo ""
echo "This is a script to configure Networking"
echo "There is no error checking. Please be careful!"
echo ""
echo -n "What static IPv4 address should this server have? "
read IPAddress
echo -n "What's the Netmask (e.g. 255.255.255.0)? "
read Netmask
echo -n "What's the Gateway IPv4 address (e.g. 192.168.0.1)? "
read Gateway
echo -n "What's the Network subnet (e.g. 192.168.0.0)? "
read Network
echo -n "What's the broadcast range (e.g. 192.168.0.255)? "
read Broadcast
echo -n "What's a DNS server to use? (e.g. 192.168.0.1) "
read Nameserver1

sed -i "s/dhcp/static/g" /etc/network/interfaces
echo "address $IPAddress" >> /etc/network/interfaces
echo "netmask $Netmask" >> /etc/network/interfaces
echo "gateway $Gateway" >> /etc/network/interfaces
echo "network $Network" >> /etc/network/interfaces
echo "broadcast $Broadcast" >> /etc/network/interfaces
echo "dns-nameservers $Nameserver1" >> /etc/network/interfaces

echo "Now applying networking changes..."
echo ""
/etc/init.d/networking restart
echo ""
echo "Networking services have been restarted."
echo "Please check for any errors above."
echo ""

