#!/bin/sh -x
# This bash script installs the pre-req's for a Kinisi Server

apt-get update -y
apt-get upgrade -y
/etc/init.d/networking restart
apt-get install openssh-server -y
apt-get install software-properties-common -y
apt-get update -y
add-apt-repository ppa:chris-lea/node.js -y
apt-get update -y
apt-get install git -y
apt-get install postgresql -y
apt-get install postgresql-server-dev-9.1 -y
apt-get install postgresql-contrib-9.1 -y

apt-get install apt-show-versions -y

