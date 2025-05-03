#!/bin/bash 

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

REPO_DIR="/git/ssl-download"
REPO_URL="github.com:Balilwana-org/ssl-download.git"

if [ ! -d "$REPO_DIR" ]; then
    git clone git@"$REPO_URL" "$REPO_DIR"
else
    cd "$REPO_DIR"
    git fetch --all
    git pull origin $(git rev-parse --abbrev-ref HEAD)
fi

gpg --batch --yes --decrypt --cipher-algo AES254 --passphrase "$CRYPT" --output /git/ssl/ssl-upload/fullchain.crypt /git/ssl-certificate/fullchain.pem
gpg --batch --yes --decrypt --cipher-algo AES254 --passphrase "$CRYPT" --output /git/ssl/ssl-upload/privkey.crypt /git/ssl-certificate/privkey.pem
