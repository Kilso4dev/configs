#!/bin/bash
#declare -A debian_PKG
DEBIAN_PKG="git ranger neovim lua5.3 npm chromium-browser chromium-codecs-ffmpeg valgrind gcc clang clangd python3 python3-pip openssh-server openssh-client make cmake "

#declare -A arch_PKG
ARCH_PKG="git ranger neovim lua npm chromium valgrind gcc clang python python-pip openssh make cmake"

#declare -A ALPINE_PKG
ALPINE_PKG="git ranger neovim lua python3 npm chromium"

#declare -A REDHAT_PKG
REDHAT_PKG="git ranger neovim lua python3 npm chromium"

#declare -A SUSE_PKG 
SUSE_PKG="git ranger neovim lua python3 npm chromium"

#declare -A GENTOO_PKG
GENTOO_PKG="git ranger neovim lua python3 npm chromium"


PYTHON_PKG="python-language-server[all]"

if [ -x "$(command -v apk)" ]; then apk add --no-cache $ALPINE_PKG;
elif [ -x "$(command -v pacman)" ]; then 
    sudo pacman -S --noconfirm $ARCH_PKG;
    sudo systemctl enable sshd.service && sudo systemctl start sshd.service;

    python -m pip install --user $PYTHON_PKG
elif [ -x "$(command -v yum)" ]; then 
    echo $REDHAT_PKG; 
elif [ -x "$(command -v emerge)" ]; then 
    echo $GENTOO_PKG; 
elif [ -x "$(command -v zypp)" ]; then 
    echo $SUSE_PKG;
elif [ -x "$(command -v apt)" ]; then 
    sudo apt install --yes $DEBIAN_PKG;
    sudo systemctl enable ssh.service && sudo systemctl start ssh.service
        
    python3 -m pip install --user $PYTHON_PKG
fi

# install typescript/javascript language server
sudo git clone https://github.com/sourcegraph/javascript-typescript-langserver.git /opt/javascript-typescript-lsp
sudo chmod a+rwx /opt/javascript-typescript-lsp && chmod a+x \
    /opt/javascript-typescript-lsp/lib/language-server.js \
    /opt/javascript-typescript-lsp/lib/language-server.js
cd /opt/javascript-typescript-lsp/ && npm install && npm run build

# Add ~/.local/bin to PATH permanently
ENV_PATH=/etc/environment
ENV_INNER=$(cat $ENV_PATH)
if [[ $ENV_INNER != *"~/.local/bin"* ]]; then
    sudo echo ${ENV_INNER%\"}:~/.local/bin\" > $ENV_PATH
fi

