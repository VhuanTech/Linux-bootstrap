#!/bin/sh
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce=5:20.10.22~3-0~ubuntu-bionic docker-ce-cli=5:20.10.22~3-0~ubuntu-bionic containerd.io docker-compose-plugin=2.14.1~ubuntu-bionic
