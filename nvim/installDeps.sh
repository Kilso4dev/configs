#!/bin/bash
#declare -A debian_PKG
DEBIAN_PKG="git ranger neovim lua5.3 npm chromium-browser chromium-codecs-ffmpeg valgrind gcc clang clangd python3"

#declare -A arch_PKG
ARCH_PKG="git ranger neovim lua npm chromium valgrind gcc clang python"

#declare -A ALPINE_PKG
ALPINE_PKG="git ranger neovim lua python3 npm chromium"

#declare -A REDHAT_PKG
REDHAT_PKG="git ranger neovim lua python3 npm chromium"

#declare -A SUSE_PKG 
SUSE_PKG="git ranger neovim lua python3 npm chromium"

#declare -A GENTOO_PKG
GENTOO_PKG="git ranger neovim lua python3 npm chromium"

echo $DEBIAN_PKG


if [ -x "$(command -v apk)" ]; then apk add --no-cache $ALPINE_PKG;
elif [ -x "$(command -v pacman)" ]; then pacman -S --noconfirm $ARCH_PKG; 
elif [ -x "$(command -v yum)" ]; then echo $REDHAT_PKG; 
elif [ -x "$(command -v emerge)" ]; then echo $GENTOO_PKG; 
elif [ -x "$(command -v zypp)" ]; then echo $SUSE_PKG;
elif [ -x "$(command -v apt)" ]; then apt install --yes $DEBIAN_PKG; fi
