#!/bin/bash
# This is a bash script to upgrade the system and the shutdown



#* @PARAM (String) $1 = minimal OR null. $1: Type of Update
    # Minimal will only execute beginning/finishing touches, and mounts drive. If not minimal, will execute all code.


# FUNCTIONS
function beginningTouches
{
    # Beginning touches
    date
    cal
    neofetch
    # curl wttr.in/?0Q/Goodyear # I swear to god this piece of shit command never works bro ong ong 50% of the time it times out 100% of the time
}


function mountDrives
{
    # Mounts old 1tb hard drive
    sudo mount /dev/sdb1 /home/dalmontron/.mnt/hdd/
}


function finishingTouches
{
    # finishing touches
    echo "
    ⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠋⠉⠁⠄⠄⠈⠙⠻⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⠟⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠙⢿⣿
    ⣿⣿⣿⣿⡿⠃⠄⠄⠄⢀⣀⣀⡀⠄⠄⠄⠄⠄⠄⠄⠈⢿
    ⣿⣿⣿⡟⠄⠄⠄⠄⠐⢻⣿⣿⣿⣷⡄⠄⠄⠄⠄⠄⠄⠈
    ⣿⣿⣿⠃⠄⠄⠄⢀⠴⠛⠙⣿⣿⡿⣿⣦⠄⠄⠄⠄⠄⠄
    ⣿⣿⠃⠄⢠⡖⠉⠄⠄⠄⣠⣿⡏⠄⢹⣿⠄⠄⠄⠄⠄⢠
    ⣿⠃⠄⠄⢸⣧⣤⣤⣤⢾⣿⣿⡇⠄⠈⢻⡆⠄⠄⠄⠄⣾
    ⠁⠄⠄⠄⠈⠉⠛⢿⡟⠉⠉⣿⣷⣀⠄⠄⣿⡆⠄⠄⢠⣿
    ⠄⠄⠄⠄⠄⠄⢠⡿⠿⢿⣷⣿⣿⣿⣿⣿⠿⠃⠄⠄⣸⣿
    ⠄⠄⠄⠄⠄⢀⡞⠄⠄⠄⠈⣿⣿⣿⡟⠁⠄⠄⠄⠄⣿⣿
    ⠄⠄⠄⠄⠄⢸⠄⠄⠄⠄⢀⣿⣿⡟⠄⠄⠄⠄⠄⢠⣿⣿
    ⠄⠄⠄⠄⠄⠘⠄⠄⠄⢀⡼⠛⠉⠄⠄⠄⠄⠄⠄⣼⣿⣿
    ⠄⠄⠄⠄⠄⡇⠄⠄⢀⠎⠄⠄⠄⠄⠄⠄⠄⠄⠄⠙⢿⣿
    ⠄⠄⠄⠄⢰⠃⠄⢀⠎⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠙"
}


# Checks if $1 is minimal. If so, do minimal update
if [ "$1" == "minimal" ]
then
    beginningTouches
    mountDrives
    finishingTouches
else
    beginningTouches
    mountDrives

    # Syncs dotfiles to git
    cd
    commitDay=$(date)
    git add ./.face ./.profile ./.bash_profile ./.bashrc ./.gitconfig ./.functions ./.aliases ./Documents/Scripts/update.sh
    git commit -m "$commitDay"
    git push origin main
    echo "finished backup of dotfiles"


    # Syncs music to git
    cd /home/dalmontron/Music/dals-mixtape/
    git add -A
    git commit -m "$commitDay"
    git push -f
    echo "finished backup of music"


    # Updates Mirrors
    sudo pacman-mirrors -f 5


    # Upgrades the system
    sudo pacman -Syu

    finishingTouches
fi









