#!/usr/bin/env bash
PACKAGES=("https://aur.archlinux.org/nitrux-icon-theme.git")
mkdir -p Nexia\ Linux/repository/nexia-dev/
mkdir -p work/
for package in "${PACKAGES[@]}"
do
    DIR=${package#*//*/}
    DIR=${DIR%.git}
    DIR=${DIR#Porucznik/}
    DIR="work/$DIR"
    mkdir -p $DIR
    git clone $package $DIR
done
