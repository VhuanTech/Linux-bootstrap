#!/bin/bash
./config_linux.sh
./install_docker.sh
./setup_python_env.sh
./install_virtualenv.sh
sudo apt install -y python3.9
