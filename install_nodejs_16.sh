#!/bin/sh
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v
sudo apt-get install -y libtool autoconf python2 libpng-dev pkgconfig nasm
