#!/usr/bin/env bash

echo "Starting update"

# geting list of packages from packages.conf
readarray -t PACKAGES < packages.conf

# Updating packages
for package in "${PACKAGES[@]}"
do
    DIR=${package#*//*/}
    DIR=${DIR%.git}
    DIR=${DIR#Porucznik/}
    DIR="work/$DIR"
    if [[ ! -d "$DIR" ]]; then
        echo "Missing $DIR repo"
    else
        echo "Found $DIR, updating"
        cd "$DIR"
        git pull
        makepkg -c
        rm *.tar.gz
        mv *.pkg.tar.xz ../../Nexia\ Linux/Repositories/nexia-dev/
        cd ../..
    fi
done

# sync local repo, if run for the first time add -a before -s
grive -s Nexia\ Linux/

echo "Updade complete"
