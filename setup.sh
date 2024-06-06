#! /bin/bash

# This script must be run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

echo "Do you have a Google Cloud Platform and a gcloud key? (y/n)"
read -r gcloudpfrm

# Creating a gloudinstall function to go through the hastle for you
function gcloudinstall {
    export GOOGLE_APPLICATION_CREDENTIALS="$key"
    echo 'export GOOGLE_APPLICATION_CREDENTIALS="$key"' >> /etc/.bashrc
    source /etc/.bashrc
    curl https://sdk.cloud.google.com | bash
    exec -l "$SHELL"
    gcloud init
    gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS"
    gcloud config set project "$project_id"
}

# Checking if the user have a gcloud key
if [ "$gcloudpfrm" == "y" ] || [ "$gcloudpfrm" == "Y" ]; then
    echo 'Great! Enter your gcloud key location. Example "/home/user/gcloud-key.json" (include double-quotes)'
    read -r key
    echo "Enter your gcloud project ID"
    read -r project_id
else
    echo "You need to have a gcloud key to use this CloudUploader properly, come back later."
    exit 1
fi

# Checking if the user already have gcloud installed
if command -v gcloud &>/dev/null; then
    echo "Google Cloud is already present and you can install the CloudUploader now."
else
    gcloudinstall
    echo "Google cloud is now ready and you can install the CloudUploader."
fi

chmod +x /CloudUploader/install.sh
