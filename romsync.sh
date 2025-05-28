#!/bin/bash

### Variables ###
retronas_dir="/data/retronas"
deck="deck.jadin.me"
deck_storage="deck@$deck:/run/media/deck/Retrodeck/retrodeck"
retroid="retroid.jadin.me"
retroid_storage="$retroid:/storage/6F36-FFFB"
rom_copy="rsync -rLi --ignore-existing --max-size=1G --exclude-from=/home/retronas/romsync/exclude.txt"

### Functions ###

update() {
  cd ~/romsync && git pull
}

roms() {

  if ping -c 1 $deck &> /dev/null
  then
    echo ""
    echo "--> Copying bios files to $deck"
    $rom_copy $retronas_dir/retrodeck/bios/ $deck_storage/bios/
    echo ""
    echo "--> Copying roms to $deck"
    $rom_copy $retronas_dir/retrodeck/roms/ $deck_storage/roms/
  fi

  if ping -c 1 $retroid &> /dev/null
  then
    echo ""
    echo "--> Copying bios files to $retroid"
    $rom_copy $retronas_dir/retroid/bios/ $retroid_storage/bios/
    echo ""
    echo "--> Copying roms to $retroid"
    $rom_copy $retronas_dir/retroid/roms/ $retroid_storage/roms/
  fi
}

usage() {
   # Display Help
   echo "Sync ROMs and saves from various devices with my retronas."
   echo
   echo "Syntax: romSync [--roms | --update | --help]"
   echo
}

### Main ###
if [ "$1" = "" ]; then
  roms
else
  while [ "$1" != "" ]; do
  case $1 in
    -r | --roms ) shift
                  echo "--> Roms"
                  roms
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

