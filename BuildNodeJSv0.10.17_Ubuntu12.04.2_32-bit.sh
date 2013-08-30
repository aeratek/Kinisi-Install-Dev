#!/bin/sh -x
# This bash script installs version 0.10.17 of Node.js
# Intended and tested for Ubuntu Desktop 12.04.2 32-bit

apt-get install g++ -y
cd /usr/local/src
wget http://nodejs.org/dist/v0.10.17/node-v0.10.17.tar.gz
tar -xvzf node-v0.10.17.tar.gz
cd node-v0.10.17
./configure
make
sudo make install
which node

