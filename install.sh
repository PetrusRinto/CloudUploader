#! /bin/bash

# install.sh

# You need to use sudo priveileges to install this 

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run by root. Please try sudo first"
    exit 1
fi

# Adding the files to the user's $PATH

mkdir /usr/local/bin/clouduploader
cp clouduploader.sh /usr/local/bin/clouduploader
chmod +x /usr/local/bin/clouduploader
mv /usr/local/bin/clouduploader/clouduploader.sh clouduploader

echo "Clouduploader has been installed to /usr/local/bin/clouduploader"
