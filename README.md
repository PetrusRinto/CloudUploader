# Introduction
Hello world! 
This is my first ever Cloud+Bash project which is the end of phase1 in the learntocloud.guide. This project emphasizes on making a script that can upload files to the Google Cloud.
I have a 90 day free Google Cloud license which made this possible by test etc.
This script currently only works on Google Cloud.

# CloudUploader to Google Cloud Storage
A bash-based CLI tool that allows you to quickly upload a file to a specified cloud storage solution, providing a simple and seamless upload experience similar to popular storage services.

# Before we start
You have to have a Google Cloud license, it's fairly easy to do just sign up here: https://console.cloud.google.com/.
Sign up for 90 days free usage with 300$ free credit (if you haven't already). No strings attached.

After this step, you need to set up a storage bucket and get your first gcloud key and project ID (These are very important!).

Save your .json file where you remember it's location!

Now you should be ready for the installation :)

# Clone the repository to your system
To make this work you need to have the git package installed and clone https://github.com/PetrusRinto/CloudUploader.git to your terminal. It is important that this is cloned to the "/" directory or it will not work as wanted.

# The setup/installation
I've tried to make the installation prosess as easy and straight forward as possible.

When you have cloned this repository to you "/" directory, you need to cd into "CloudUploader". Here is were the juicy stuff is stored.

In the "CloudUploader" directory you need to give yourself permissions to execute the installer.sh file (You dont have to pay much attention to the other files, because the installer script will do everything for you)

When you have given yourself permission to execute the installer.sh file, you can launch it with sudo ./installer.sh.
This will prompt you to enter where you stored the .json file and ask you for you Project ID.

After you've provided this, you can sit back and let the script do it's thing. (remember to still keep your attention, because the script might want to prompt you some more later on the installation.)

When the installation is complete you will see a message that lets you know this.

# How to Upload a file to the cloud
When the installation is complete, you can finally Upload to your cloud.

To do this you simply have to enter "clouduploader /path/to/file.txt your_bucket_name" hit enter and you will get a message if it were successful or not.

You can also check the result by refreshing "https://console.cloud.google.com/where_your_bucket/is_located"
and see if your file was uploaded to you bucket.

# Future upgrades
- Upload multiple files at once
- Add a progress bar
- Enable file synchronization --if the file already exists in the cloud I want to have the script prompt for overwrite, rename or skip.
-Integrate encryption
