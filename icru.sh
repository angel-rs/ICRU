#!/bin/bash

# Retrieve image from clipboard
xclip -selection clipboard -t image/png -o > ./tmp.png || (echo -e "Clipboard content is not an image \e[31m✘\e[0m" && exit 1)

echo -e "\e[90mUploading image...\e[0m"

randomString=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
uploadTo="https://transfer.sh/$randomString.png"

# Upload image using transfer.sh
URL=$(curl --silent --upload-file ./tmp.png $uploadTo) || (echo -e "Some error ocurred uploading the image \e[31m✘\e[0m" && exit 1)

# Place URL to the clipboard
echo -n $URL | xclip -selection clipboard

echo -e "\e[90m$URL\e[0m"

echo -e "Image URL copied to the clipboard \e[32m✔\e[0m"

# Remove tmp image
rm ./tmp.png
