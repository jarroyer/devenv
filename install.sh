#!/bin/bash

# Drop in bash_profile
echo "Installing .bash_profile"

mv ${HOME}/.bash_profile ${HOME}/.bash_profile.bckp
cp ./cfg/bash_profile ${HOME}/.bash_profile

# Make .dirs
mkdir ${HOME}/.bin
mkdir ${HOME}/.tb
mkdir ${HOME}/.build

# Copy tb scripts
cp scripts/tb ${HOME}/.bin/tb
chmod 744 ${HOME}/.bin/tb

cp scripts/ip ${HOME}/.tb/ip
chmod 744 ${HOME}/.tb/ip
