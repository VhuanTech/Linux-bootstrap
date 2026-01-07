#!/bin/sh
# https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html#ubuntu-lts
sudo apt-get install linux-headers-$(uname -r)
distribution=$(
  . /etc/os-release
  echo $ID$VERSION_ID | sed -e 's/\.//g'
)
# wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-keyring_1.0-1_all.deb
# sudo dpkg -i cuda-keyring_1.0-1_all.deb
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
# sudo apt-get -y install cuda-drivers
# Install the latest CUDA toolkit
sudo apt-get -y install cuda
sudo apt-get -y install cuda-toolkit-12-8

# Add CUDA Toolkit to PATH
export PATH=/usr/local/cuda/bin:$PATH
# Add CUDA Libraries to LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64\  ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# cat /proc/driver/nvidia/version
echo "System reboot is needed. Will you reboot now? (Y/n)"
read input
if [ "$input" = "n" ]; then
  echo "Please reboot manually!"
else
  sudo reboot
fi
