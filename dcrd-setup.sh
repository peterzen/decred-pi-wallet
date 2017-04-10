#!/bin/bash



# start dcrd
mkdir ~/.dcrd ~/.dcrwallet ~/.dcrctl

RPC_PASSWORD=$(openssl rand -hex 32)
echo "rpcpass=$RPC_PASSWORD" | tee -a dcrd.conf dcrctl.conf  > /dev/null
echo "password=$RPC_PASSWORD" | tee -a dcrwallet.conf > /dev/null
cp dcrd.conf ~/.dcrd
cp dcrwallet.conf ~/.dcrwallet
cp dcrctl.conf ~/.dcrctl



