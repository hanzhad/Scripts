#! /bin/bash

declare -a list=(
    "###" 
    "###" 
)
PROJECT_FOLDER_NAME=backend

mkdir -p ./${PROJECT_FOLDER_NAME}
cd ./${PROJECT_FOLDER_NAME}

while getopts u:p: option
do
case "${option}"
in
u) USER=${OPTARG};;
p) PASSWORD=${OPTARG};;
esac
done

for repo in "${list[@]}"
do
 /usr/bin/git clone https://${USER}:${PASSWORD}####${repo}.git
done
