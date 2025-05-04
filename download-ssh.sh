#!/bin/bash 

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
source vars.txt

if [ ! -d "$SSL_DESTINATION" ]; then
    mkdir "$SSL_DESTINATION"
fi

if [ ! -d "$REPO_DIR" ]; then
    git clone git@"$REPO_URL" "$REPO_DIR"
else
    cd "$REPO_DIR"
    git fetch --all
    git pull origin $(git rev-parse --abbrev-ref HEAD)
fi

gpg --batch --yes --decrypt --cipher-algo AES256 --passphrase "$CRYPT" --output "$SSL_DESTINATION/fullchain.pem" "$REPO_DIR/fullchain.crypt"
gpg --batch --yes --decrypt --cipher-algo AES256 --passphrase "$CRYPT" --output "$SSL_DESTINATION/privkey.pem" "$REPO_DIR/privkey.crypt" 
