# 1. Install dependencies
sudo apt update
sudo apt install -y wget gnupg ca-certificates

# 2. Add Kitware's signing key
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -

# 3. Add the Kitware APT repository
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main'

# 4. Update and install CMake
sudo apt update
sudo apt install -y cmake
