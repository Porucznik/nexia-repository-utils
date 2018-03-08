#!/usr/bin/env bash

# geting list of packages from packages.conf
readarray -t PACKAGES < packages.conf

# creating work directories
mkdir -p Nexia\ Linux/repository/nexia-dev/
mkdir -p work/

# cloning packages git repos
for package in "${PACKAGES[@]}"
do
    DIR=${package#*//*/}
    DIR=${DIR%.git}
    DIR=${DIR#Porucznik/}
    DIR="work/$DIR"
    if [[ ! -d "$DIR" ]]; then
        echo "Found new $DIR, creating"
        mkdir -p $DIR
        git clone $package $DIR
        echo "$DIR created"
    else
        echo "Found existing $DIR, countinuing"
    fi
done

# sync local repo, if run for the first time add -a before -s
grive -s Nexia\ Linux/

echo "Setup complete"
