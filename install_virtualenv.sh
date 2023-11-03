sudo apt install -y python3-pip
sudo apt install -y virtualenv virtualenvwrapper
sudo python3 -m pip install setuptools
sudo python3 -m pip install virtualenvwrapper --trusted-host mirrors.aliyun.com
cat << EOF >> ~/.bashrc
export WORKON_HOME=/data/system/virtualenvs
export PROJECT_HOME=/data/workspace
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
EOF
echo 'Run "source ~/.bashrc" manually'
