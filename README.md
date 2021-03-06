## Decred cold wallet on the Raspberry Pi

This is a guide for setting up a [Decred](https://www.decred.org) cold wallet on the Raspberry Pi.


1. Get the [Raspbian Lite image](https://www.raspberrypi.org/downloads/raspbian/) and [flash it onto a USB stick or SD card](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)


2. If you want to perform a headless installation (e.g. don't have a keyboard connected to the Pi) you can [enable SSH](https://www.raspberrypi.org/documentation/remote-access/ssh/) before booting the Pi for the first time.  Note that this way you won't have a 100% cold wallet.

3. Log into the Pi for the first time and change your user password.  Set up SSH access if you need to log in remotely.

4. Download the installer script and verify its SHA256 value:

````bash
wget https://raw.githubusercontent.com/peterzen/decred-pi-wallet/master/install.sh
````

````bash
sha256sum install.sh
7e1b537d4a607ce3bc10902ebe5a75b3b8725381153d0de46eb5346399f91068  install.sh
````

5. Run the install script that will update the system, install all the required packages and configure the Pi's [hardware random number generator (RNG)](http://fios.sector16.net/hardware-rng-on-raspberry-pi/).  After the upgrade and package installation is completed, it will ask you to confirm the kernel upgrade - answer *Yes*.  Once the upgrade is finished, the Pi will reboot.

````bash
chmod +x install.sh && ./install.sh
````

6. If you want to run a cold wallet, you can now disconnect the network cable and carry on with creating your wallet offline.

7. After the reboot, log back in and proceed with creating your wallet: see [Offline wallets](https://github.com/chappjc/dcrwallet/blob/master/docs/offline_wallets.md) for more information.






Donate if you like the project: `DsSs1yBDvJXj4S74Vb3ECgAu8fPTFRRFPMd`
