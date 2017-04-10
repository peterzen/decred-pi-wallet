#!/bin/bash

# set up locales so that the installation doesn't give us warnings
echo 'LANGUAGE="en_GB.UTF-8"' | sudo tee -a /etc/default/locale
echo 'LC_ALL="en_GB.UTF-8"' | sudo tee -a /etc/default/locale

# add Debian backports
sudo apt-key adv   --keyserver keyserver.ubuntu.com --recv 7638D0442B90D010
echo "deb http://ftp.debian.org/debian jessie-backports main" | sudo tee -a /etc/apt/sources.list

# update distro to latest
sudo apt-get update
sudo apt-get -y dist-upgrade

# install required packages
sudo apt-get -y install rng-tools rpi-update golang-1.7-go build-essential git

# set up hardware RNG generator
# http://fios.sector16.net/hardware-rng-on-raspberry-pi/
echo 'HRNGDEVICE=/dev/hwrng' | sudo tee -a /etc/default/rng-tools
echo bcm2708-rng | sudo tee -a /etc/modules
# update kernel to latest, this includes the RNG driver as well
sudo rpi-update


# set up Decred tools

mkdir -p ~/go/src; mkdir ~/go/bin

echo 'export GOPATH=/home/pi/go' >> ~/.bashrc
echo 'export PATH=$GOPATH/bin:$PATH:/usr/lib/go-1.7/bin' >> ~/.bashrc    

. ~/.bashrc

# install glide
curl -s https://glide.sh/get | sh

# compile dcrd
git clone https://github.com/decred/dcrd $GOPATH/src/github.com/decred/dcrd
cd $GOPATH/src/github.com/decred/dcrd
glide install
go install $(glide nv)
go build
go install
cd


git clone https://github.com/decred/dcrwallet $GOPATH/src/github.com/decred/dcrwallet
cd $GOPATH/src/github.com/decred/dcrwallet
glide install
go install $(glide nv)
go build
go install
cd


git clone https://github.com/decred/dcraddrgen $GOPATH/src/github.com/decred/dcraddrgen
cd $GOPATH/src/github.com/decred/dcraddrgen
glide install
go install $(glide nv)
go build
go install
cd



echo 
echo Installation done, rebooting in a few seconds
sleep 5
sudo reboot