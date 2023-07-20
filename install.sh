#!/bin/bash
source config/bash_profile

# Drop in bash_profile
echo "Installing .bash_profile"

mv ${HOME}/.bash_profile ${HOME}/.bash_profile.bckp
cp ${REPO_CONFIG_DIR}/bash_profile ${HOME}/.bash_profile

# Drop in .files
cp ${REPO_CONFIG_DIR}/inputrc ${HOME}/.inputrc
cp ${REPO_CONFIG_DIR}/gitconfig ${HOME}/.gitconfig
cp ${REPO_CONFIG_DIR}/hushlogin ${HOME}/.hushlogin
cp ${REPO_CONFIG_DIR}/env ${HOME}/.env

# Make .dirs
mkdir ${HOME_LOCAL_DIR} 2> /dev/null
mkdir ${HOME_TB_DIR} 2> /dev/null
mkdir ${HOME_BIN_DIR} 2> /dev/null
mkdir ${HOME_BUILD_DIR} 2> /dev/null

# Copy tb scripts
cp ${REPO_SCRIPT_DIR}/tb ${HOME_BIN_DIR}/tb
chmod 744 ${HOME_BIN_DIR}/tb

cp ${REPO_SCRIPT_DIR}/ip ${HOME_TB_DIR}/ip
chmod 744 ${HOME_TB_DIR}/ip

# Install dependencies

if which -s make; then
    echo "Make exists, skipping install"
else
    echo "Installing Make"
    cd $HOME_BUILD_DIR
    git clone https://github.com/wkusnierczyk/make.git
    cd make
    ./configure
    ./make
    mv make $HOME_BIN_DIR
fi

if which -s cmake; then
    echo "CMake exists, skipping install"
else
    echo "Installing CMake"
    cd $HOME_BUILD_DIR
    git clone https://github.com/Kitware/CMake.git
    cd CMake
    ./bootstrap --prefix=${HOME_LOCAL_DIR} && make && make install
fi


if which -s neofetch; then
    echo "Neofetch exists, skipping install"
else
    echo "Installing neofetch"
    cd $HOME_BUILD_DIR
    git clone https://github.com/dylanaraps/neofetch.git
    cd neofetch
    make PREFIX=${HOME_LOCAL_DIR} install
fi

if which -s python; then
    echo "Python exists, skipping install"
else
    echo "Installing python"
    cd $HOME_BUILD_DIR
    curl https://www.python.org/ftp/python/3.11.3/Python-3.11.3.tgz --output python3.tar.gz
    tar -xzvf python3.tar.gz
    cd Python-3.11.3
    ./configure --prefix=${HOME_LOCAL_DIR} --enable-optimization
    make install
    cd $HOME_BIN_DIR
    ln -s python3 python
    chmod 711 python
fi

if which -s pip; then
    echo "Pip exists, skipping install"
else
    echo "Installing pip"
    cd $HOME_BIN_DIR
    curl https://bootstrap.pypa.io/pip/pip.pyz --output pip.pyz
fi


# Clean build dir
echo "Cleaning up the build directory"
cd $HOME_BUILD_DIR
rm -rf ./*

# Footer
echo 
echo "Install to ${HOME_LOCAL_DIR} is complete"
