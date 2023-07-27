sudo apt install -y python3-pip
sudo apt install -y virtualenv virtualenvwrapper
sudo python3 -m pip install setuptools
sudo python3 -m pip install virtualenvwrapper --trusted-host mirrors.aliyun.com
cat << EOF >> ~/.bashrc
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/workspace
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
EOF
