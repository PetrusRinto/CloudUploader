#! /bin/bash

# install.sh

# You need to use sudo priveileges to install this 

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run by root. Please try sudo first"
    exit 1
fi

# Adding the files to the user's $PATH
sudo mkdir -p /usr/local/bin/gclouduploader
sudo cp clouduploader.sh /usr/local/bin/gclouduploader
sudo chmod +x /usr/local/bin/gclouduploader/clouduploader.sh
sudo ln -s /usr/local/bin/gclouduploader/clouduploader.sh /usr/local/bin/clouduploader

if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
    echo "Adding /usr/local/bin to PATH"
    echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
    source ~/.bashrc
fi


echo "Install complete! Before you can now use command 'clouduploader'."
echo 'You need to enter "gcloud init" in your terminal to login'
