#!/bin/bash

sudo mv /etc/apt/sources.list /etc/apt/sources.list.org
sudo cp sources.list.focal.aliyun /etc/apt/sources.list
sudo apt udpate

# utils
sudo apt install -y unzip cmake
sudo apt install -y wget gnupg ca-certificates

# python
sudo apt install -y python3.9
# virtualenv
sudo source install_virtualenv.sh
# pip source etc.
sudo source setup_python_env.sh

# node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install 22

# vim
sudo apt install -y neovim
git clone https://github.com/LazyVim/starter ~/.config/nvim
