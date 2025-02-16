#!/bin/bash

### Variables ###
retronas_dir='/data/retronas'
deck='deck.jadin.me'
deck_storage='deck@deck.jadin.me:/run/media/deck/Retrodeck/retrodeck'
save_sync="rsync -rLi --times --update"
rom_copy="rsync -rLi --ignore-existing --exclude-from=/mnt/user/appdata/romSync/exclude.txt"

### Functions ###

update() {
  cd ~/romsync && git pull
}

saves() {
  if ping -c 1 $deck &> /dev/null
  then
    echo ""
    echo "--> Backing up saves from $deck"
    $save_sync $deck_storage/saves/ $retronas_dir/retrodeck/saves/
    echo ""
    echo "--> Updating $deck with missing saves"
    $save_sync $retronas_dir/retrodeck/saves/ $deck_storage/saves/
  fi
}

roms() {

  if ping -c 1 $deck &> /dev/null
  then
    echo ""
    echo "--> Copying bios files to $deck"
    $rom_copy $retronas_dir/retrodeck/bios/ $deck_storage/bios/
    echo ""
    echo "--> Copying froms to $deck"
    $rom_copy $retronas_dir/retrodeck/roms/ $deck_storage/roms/
  fi
}

usage() {
   # Display Help
   echo "Sync ROMs and saves from various devices with my retronas."
   echo "Using no flags will will first sync saves then roms. If any"
   echo "devices are unreachable it will skip those devices."
   echo
   echo "Syntax: romSync [--roms | --saves | --update | --help]"
   echo
}

### Main ###
if [ "$1" = "" ]; then
  saves
  roms
else
  while [ "$1" != "" ]; do
  case $1 in
    -r | --roms ) shift
                  echo "--> Roms"
                  roms
                  echo ""
                  ;;
    -s | --saves) shift
                  echo "--> Saves"
                  saves
                  echo ""
                  ;;
    -u | --update) shift
                  echo "--> Pulling updates from GitHub"
                  update
                  ;;
    -h | --help ) usage
                  exit
                  ;;
    * )           usage
                  exit 1
  esac
  shift
done
fi

