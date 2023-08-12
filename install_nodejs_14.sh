#!/bin/sh
sudo apt remove nodejs
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v
sudo apt-get install -y libtool pkg-config autoconf nasm python2
