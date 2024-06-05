#! /bin/bash

# Validating required arguments
if [ $# -eq 0 ]; then
     echo "You have to provide a file and destination"
     exit 1
fi


# Creating a function to upload a file
upload_file() {
	local file=$1
	local destination=$2

	gsutil cp "$file" "gs://$destination"

	if [ $? -eq 0 ]; then
		echo "Upload was successful!"
		exit 0
	else
		echo "Error, upload unsuccessful"
		exit 1
	fi
}

# Checking if the file exists
if [ -f "$1" ]; then
	upload_file "$1" "$2"
else
	echo "The file you want to upload do not exist"
	exit 1
fi
