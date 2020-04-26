#!/bin/bash
#declare -A debian_PKG
DEBIAN_PKG="git ranger neovim lua5.3 npm chromium-browser chromium-codecs-ffmpeg valgrind gcc clang clangd python3 python3-pip openssh-server openssh-client"

#declare -A arch_PKG
ARCH_PKG="git ranger neovim lua npm chromium valgrind gcc clang python python-pip openssh"

#declare -A ALPINE_PKG
ALPINE_PKG="git ranger neovim lua python3 npm chromium"

#declare -A REDHAT_PKG
REDHAT_PKG="git ranger neovim lua python3 npm chromium"

#declare -A SUSE_PKG 
SUSE_PKG="git ranger neovim lua python3 npm chromium"

#declare -A GENTOO_PKG
GENTOO_PKG="git ranger neovim lua python3 npm chromium"


PYTHON_PKG="autopep8 McCabe python-language-server"


if [ -x "$(command -v apk)" ]; then apk add --no-cache $ALPINE_PKG;
elif [ -x "$(command -v pacman)" ]; then 
    pacman -S --noconfirm $ARCH_PKG;
    systemctl enable sshd.service && systemctl start sshd.service;
    python -m pip install --user $PYTHON_PKG
elif [ -x "$(command -v yum)" ]; then 
    echo $REDHAT_PKG; 
elif [ -x "$(command -v emerge)" ]; then 
    echo $GENTOO_PKG; 
elif [ -x "$(command -v zypp)" ]; then 
    echo $SUSE_PKG;
elif [ -x "$(command -v apt)" ]; then 
    apt install --yes $DEBIAN_PKG;
    systemctl enable ssh.service && systemctl start ssh.service
    python3 -m pip install --user $PYTHON_PKG
fi

ENV_PATH=/etc/environment
ENV_INNER=$(cat $ENV_PATH)
echo ${ENV_INNER%\"}:\$HOME/.local/bin\" > $ENV_PATH
