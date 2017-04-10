## Decred cold wallet on the Raspberry Pi

This is a guide for setting up a Decred cold wallet on the Raspberry Pi.



1. Get the [Raspbian Lite image](https://www.raspberrypi.org/downloads/raspbian/) and [flash it onto a USB stick or SD card](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)


2. If you want to do a headless installation (e.g. don't have a keyboard connected to the Pi) you can [enable SSH](https://www.raspberrypi.org/documentation/remote-access/ssh/) before booting the Pi for the first time.  Note that this way you won't have a 100% cold wallet.

3. Log into the Pi for the first time and change your user password.  Set up SSH access if you need to log in remotely.

4. Run the install script that will update the system, install all the required packages and configure the RNG.  After the upgrade and package installation is completed it will ask you to confirm the kernel upgrade - answer Yes.  Once the upgrade is finished, the Pi will reboot.

```
curl -s https://raw.githubusercontent.com/peterzen/decred-pi-wallet/master/install.sh | sh
````

5. If you want to run a cold wallet, you can now disconnect the network cable and carry on with creating your wallet offline.

6. Run `./dcrd-setup.sh`.  This will configure the Decred suite of tools and once it finishes you can run `dcrd` and `dcrwallet` in local mode (`dcrd` won't connect to any peers).  

7. Proceed with creating your wallet: see [Offline wallets](https://github.com/chappjc/dcrwallet/blob/master/docs/offline_wallets.md)


