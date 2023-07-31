#!/bin/sh
sudo cp /etc/apt/sources.list /etc/apt/sources.list.org
sudo cp sources.list.focal /etc/apt/sources.list
sudo apt update
