#!/bin/bash

sudo mv /etc/apt/sources.list /etc/apt/sources.list.org
sudo cp sources.list.focal.aliyun /etc/apt/sources.list
sudo apt udpate
