#!/bin/bash 

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/vars.txt"

#check if destination for ssl files there
if [ ! -d "$SSL_DESTINATION" ]; then
    mkdir "$SSL_DESTINATION"
fi

#check if gpg installed, for debianoid systems
if ! command -v gpg &> /dev/null; then
    apt update
    apt install -y gnupg
fi

#check if ssl-repository there, create or update
if [ ! -d "$REPO_DIR" ]; then
    git clone git@"$REPO_URL" "$REPO_DIR"
else
    cd "$REPO_DIR"
    git fetch --all
    git pull origin $(git rev-parse --abbrev-ref HEAD)
fi

#decrypt files
gpg --batch --yes --decrypt --cipher-algo AES256 --passphrase "$CRYPT" --output "$SSL_DESTINATION/fullchain.pem" "$REPO_DIR/fullchain.crypt"
gpg --batch --yes --decrypt --cipher-algo AES256 --passphrase "$CRYPT" --output "$SSL_DESTINATION/privkey.pem" "$REPO_DIR/privkey.crypt" 
