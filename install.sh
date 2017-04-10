#!/bin/bash


DECRED_RELEASE=v0.8.2
INSTALLER_BINARY=dcrinstall-linux-arm-$DECRED_RELEASE

# set up locales so that the installation doesn't give us warnings
echo 'LANGUAGE="en_GB.UTF-8"' | sudo tee -a /etc/default/locale >/dev/null
echo 'LC_ALL="en_GB.UTF-8"' | sudo tee -a /etc/default/locale >/dev/null

# add Debian backports
sudo apt-key adv   --keyserver keyserver.ubuntu.com --recv 7638D0442B90D010
echo "deb http://ftp.debian.org/debian jessie-backports main" | sudo tee -a /etc/apt/sources.list

# update distro to latest
sudo apt-get update
sudo apt-get -y dist-upgrade

# install required packages
sudo apt-get -y install rng-tools rpi-update jq

# set up hardware RNG generator
# http://fios.sector16.net/hardware-rng-on-raspberry-pi/
echo 'HRNGDEVICE=/dev/hwrng' | sudo tee -a /etc/default/rng-tools
echo bcm2708-rng | sudo tee -a /etc/modules
# update kernel to latest, this includes the RNG driver as well
sudo rpi-update

# create & populate decred configuration directories

mkdir ~/.dcrd ~/.dcrwallet ~/.dcrctl

RPC_PASSWORD=$(openssl rand -hex 32)

tee .dcrd/dcrd.conf > /dev/null <<DCRD_CONF
connect=127.0.0.1:12345
listen=127.0.0.1
rpclisten=127.0.0.1
rpcuser=rpc
rpcpass=$RPC_PASSWORD
DCRD_CONF

tee .dcrctl/dcrctl.conf > /dev/null <<DCRCTL_CONF
rpcuser=rpc
rpcpass=$RPC_PASSWORD
DCRCTL_CONF

tee .dcrwallet/dcrwallet.conf > /dev/null <<DCRWALLET_CONF
username=rpc
password=$RPC_PASSWORD
DCRWALLET_CONF



# set up Decred tools
echo 'export PATH=/home/pi/decred:$PATH' >> ~/.bashrc
. ~/.bashrc


echo Downloading Decred $DECRED_RELEASE installer
wget -q https://github.com/decred/decred-release/releases/download/$DECRED_RELEASE/$INSTALLER_BINARY
chmod +x $INSTALLER_BINARY
./$INSTALLER_BINARY


echo 
echo
echo Disconnect your network cable now if you want to create your wallet in offline mode.
echo
echo Installation done, rebooting in a few seconds.  
echo

sleep 10
sudo reboot