#!/bin/sh -x
# This bash script performs the following Postgresql setup actions: 
#   1. Changes the postgres user password to a new password, 
#      as chosen by the user running the script. 
#   2. Modifies the /etc/postgresql/9.1/main/postgresql.conf
#      file to accept all incoming connections to the database
#      (additional security measures taken in a later step). Also
#      modifies this file to increase the shared memory setting 
#      (shared_buffers changes from 24MB to 64MB). 
#   3. Modifies the /etc/postgresql/9.1/main/pg_hba.conf file 
#      to have md5 encryption for all users and also configures
#      the database server to accept connections from a specific 
#      IP address range on the LAN, only (192.168.0.0/24). 
# It does no error checking at the present time

echo ""
echo "This is a script to configure the Postgresql database server"
echo "There is no error checking. Please be careful!"
sleep 3
echo ""
echo -n "You will now be prompted for a new postgres user password."
echo ""
sleep 1
#read PostgresUserPassword
sudo passwd postgres
echo ""
echo "Done setting postgres user password."
echo "Please check for any errors above."
sleep 1

#Now configure md5 encryption/authentication, rather than peer
#Hack right now is a quick find-and-remplate for the word "peer"
#It would be better not to modify the entire commented text of the file,
#which provides instructions. 
echo ""
echo "Now modifying the pg_hba.conf file to reflect md5 authentication..."
sleep 1
sed -i "s/peer/md5/g" /etc/postgresql/9.1/main/pg_hba.conf 
echo "   ...Done configuring for md5 authentication."
sleep 1
#Now adding to the /etc/pg_hba_conf file the LAN IP's to accept connections from
echo "Now configuring additional security measures for the database server."
echo ""
sleep 1
echo "Which IP address range would you like to accept connections from?"
echo "  e.g. 192.168.0.0/24" 
read IPAddressRange
sleep 1
echo "host    all             all             $IPAddressRange          md5" >> /etc/postgresql/9.1/main/pg_hba.conf
echo "   ...Done modifying pg_hba.conf file." 
echo ""

#Now configure the postgresql server to accept incoming connections.
#Hack right now changes all "localhost" text to "*".
#It would be nice to improve this. 
#echo ""
#this memory portion is broken, has a bug where the server won't restart...
#echo "Now modifying the postgresql.conf file to increase buffer memory."
#sleep 1
#sed -i "s/24MB/64MB/g" /etc/postgresql/9.1/main/postgresql.conf
#echo "Done."
echo ""
echo "Now modifying the postgresql.conf file to accept connections."
echo ""
sleep 1
sed -i "s/localhost/*/g" /etc/postgresql/9.1/main/postgresql.conf
sed -i "s/#listen_addresses/listen_addresses/g" /etc/postgresql/9.1/main/postgresql.conf
echo "Done."
echo ""


#Now restart the server.
echo ""
sudo service postgresql restart
echo "Done restarting the database server."
echo ""



#echo ""
#echo "For script development purposes, we'll now test listing databases..."
#echo "" 
#psql postgres -U kinisi_dba -c "\list"
#echo ""

#sed -i "s/dhcp/static/g" /etc/network/interfaces
#echo "address $IPAddress" >> /etc/network/interfaces
#echo "Now applying networking changes..."
#echo ""
#/etc/init.d/networking restart
#echo ""
#echo "Networking services have been restarted."
#echo "Please check for any errors above."
#echo ""

