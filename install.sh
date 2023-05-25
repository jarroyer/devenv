#!/bin/bash
source config/bash_profile

# Drop in bash_profile
echo "Installing .bash_profile"

mv ${HOME}/.bash_profile ${HOME}/.bash_profile.bckp
cp ${REPO_CONFIG_DIR}/bash_profile ${HOME}/.bash_profile

# Make .dirs
mkdir ${HOME_LOCAL_DIR}
mkdir ${HOME_TB_DIR}
mkdir ${HOME_BIN_DIR}
mkdir ${HOME_BUILD_DIR}

# Copy tb scripts
cp ${REPO_SCRIPT_DIR}/tb ${HOME_BIN_DIR}/tb
chmod 744 ${HOME_BIN_DIR}/tb

cp ${REPO_SCRIPT_DIR}/ip ${HOME_TB_DIR}/ip
chmod 744 ${HOME_TB_DIR}/ip

# Install dependencies

echo "Installing Make"
cd $HOME_BUILD_DIR
git clone https://github.com/wkusnierczyk/make.git
cd make
./configure
./make
mv make $HOME_BIN_DIR

echo "Installing CMake"
cd $HOME_BUILD_DIR
git clone https://github.com/Kitware/CMake.git
cd CMake
./bootstrap --prefix=${HOME_LOCAL_DIR} && make && make install
