#! /bin/bash

if [[ -n "${1}" && -n "${2}" ]]
then
    echo "Renaming primary group..."
    groupmod -n "${2}" "${1}"

    echo "Renaming user..."
    usermod -l "${2}" "${1}"

    echo "Updating description..."
    usermod -c "${2}" "${2}"

    if [[ -d /home/"${1}" ]]
    then
        echo "Renaming home folder..."
        mv /home/"${1}" /home/"${2}"
    fi

    echo "Assigning home folder..."
    usermod -d /home/"${2}" "${2}"

    echo 'Done!'

else
    echo "Usage: "${0}" CURRENT_USERNAME DESIRED_USERNAME"
fi
