#!/bin/bash

# Courtesy of https://github.com/jesseduffield/lazydocker/blob/master/scripts/install_update_linux.sh

# map different architecture variations to the available binaries
ARCH=$(uname -m)
case $ARCH in
    i386|i686) ARCH=x86 ;;
    armv6*) ARCH=armv6 ;;
    armv7*) ARCH=armv7 ;;
    aarch64*) ARCH=arm64 ;;
esac

# prepare the download URL
GITHUB_LATEST_VERSION=$(curl -L -s -H 'Accept: application/json' https://github.com/Phantas0s/ottosocial/releases/latest | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
GITHUB_FILE="ottosocial_${GITHUB_LATEST_VERSION//v/}_$(uname -s)_${ARCH}.tar.gz"
GITHUB_URL="https://github.com/Phantas0s/ottosocial/releases/download/${GITHUB_LATEST_VERSION}/${GITHUB_FILE}"
echo $GITHUB_URL

# install/update the local binary
curl -LO $GITHUB_URL
mv ${GITHUB_FILE} ottosocial.tar.gz
tar xzvf ottosocial.tar.gz ottosocial
sudo mv -f ottosocial /usr/local/bin/
rm ottosocial.tar.gz
