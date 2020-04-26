#!/bin/bash
declare -A debian_PKG
debian_PKG=(git ranger neovim "lua5.3" npm chromium-browser chromium-codecs-ffmpeg)

declare -A arch_PKG
arch_PKG=(git ranger neovim lua npm chromium)

declare -A ALPINE_PKG
APLINE_PKG=(git ranger neovim lua npm chromium)

declare -A REDHAT_PKG
REDHAT_PKG=(git ranger neovim lua npm chromium)


if [ -x "$(command -v apk)" ]; then apk add --no-cache ${ALPINE_PKG}; fi
if [ -x "$(command -v pacman)" ]; then pacman -S --noconfirm ${ARCH_PKG}; fi
if [ -x "$(command -v yum)" ]; then echo ${REDHAT_PKG}; fi
if [ -x "$(command -v emerge)" ]; then echo ${GENTOO_PKG}; fi
if [ -x "$(command -v zypp)" ]; then echo ${SUSE_PKG}; fi
if [ -x "$(command -v apt)" ]; then apt install --yes ${DEBIAN_PKG}; fi
