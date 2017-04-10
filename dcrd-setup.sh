#!/bin/bash



# start dcrd
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


