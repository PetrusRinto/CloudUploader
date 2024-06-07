#! /bin/bash

# This script must be run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

echo "Do you have a Google Cloud Platform and a gcloud key? (y/n)"
read -r gcloudpfrm

# Creating a function to install gcloud SDK
function gcloudinstall {
    echo "Installing Google Cloud SDK..."

    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

# Adding Cloud SDK distro
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Importing the Google Cloud key
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Updating and installing the SDK
    apt-get update && apt-get install -y google-cloud-sdk

    if [ $? -ne 0 ]; then
        echo "Failed to install gcloud SDK."
        exit 1
    fi
    
    echo 'export PATH=$PATH:$HOME/google-cloud-sdk/bin' >> ~/.bashrc
    export PATH=$PATH:$HOME/google-cloud-sdk/bin
    source ~/.bashrc
}

# Creating a gloud authentication function
function gcloud_auth {
    gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS"
    if [ $? -ne 0 ]; then
        echo "Failed to authenticate with gcloud"
        exit 1
    fi
    gcloud config set project "$project_id"
}

# Checking if the user have a gcloud key
if [ "$gcloudpfrm" == "y" ] || [ "$gcloudpfrm" == "Y" ]; then
    echo 'Great! Enter your gcloud key location. Example "/home/user/gcloud-key.json" (include double-quotes)'
    read -r key
    export GOOGLE_APPLICATION_CREDENTIALS="$key"
    echo "Enter your gcloud project ID"
    read -r project_id
else
    echo "You need to have a Google Cloud key to use this CloudUploader properly, come back later."
    exit 1
fi

# Checking if gcloud is installed and in PATH
if ! command -v gcloud &> /dev/null; then
    echo "gcloud is not installed. Installing now..."
    gcloudinstall

    # Ensuring the environment is updated
    source ~/.bashrc
else
    echo "gcloud is already installed."
fi


# Checking if the user already have logged into Google Cloud
if gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q "."; then
    echo "You are already logged in, running the setup.sh file..."
else
    gcloud_auth
fi


echo "All is done! Installing the setup file right now..."
chmod +x /CloudUploader/setup.sh
./setup.sh
