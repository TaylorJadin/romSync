#!/bin/bash

### Variables ###
device1='piboy'
device2='gpi'
sync="rsync -nrPt --exclude-from=/mnt/user/appdata/bin/exclude.txt"
mirror="rsync -nrPt --del --exclude-from=/mnt/user/appdata/bin/exclude.txt"
mirror-all="rsync -nrPt --del"

### Functions ###

pull() {
  if ping -c 1 $device1 &> /dev/null
  then
    echo ""
    echo "===================================="
    echo "Syncing roms from $device1"
    $sync pi@$device1:/home/pi/RetroPie/roms/ /mnt/user/media/ROMs/
    echo "===================================="
    echo ""
    echo "===================================="
    echo "Backing up configs from $device1"
    $mirror-all pi@$device1:/opt/retropie/configs/ /mnt/user/backups/$device1/configs
    echo "===================================="
    echo ""
    echo "===================================="
    echo "Backing up BIOS folder from $device1"
    $mirror-all pi@$device1:/home/pi/RetroPie/BIOS/ /mnt/user/backups/$device1/BIOS
    echo "===================================="
  fi

  if ping -c 1 $device2 &> /dev/null
  then
    echo ""
    echo "===================================="
    echo "Syncing roms from $device2"
    $sync pi@$device2:/home/pi/RetroPie/roms/ /mnt/user/media/ROMs/
    echo "===================================="
    echo ""
    echo "===================================="
    echo "Backing up configs from $device2"
    $mirror-all pi@$device2:/opt/retropie/configs/ /mnt/user/backups/$device2/configs
    echo "===================================="
    echo ""
    echo "===================================="
    echo "Backing up BIOS folder from $device2"
    $mirror-all pi@$device2:/home/pi/RetroPie/BIOS/ /mnt/user/backups/$device2/BIOS
    echo "===================================="
  fi
}

push() {
  if ping -c 1 $device1 &> /dev/null
  then
    echo ""
    echo "===================================="
    echo "Mirroring from unraid to $device1"
    $mirror /mnt/user/media/ROMs/ pi@$device1:/home/pi/RetroPie/roms/
    echo "===================================="
  fi

  if ping -c 1 $device2 &> /dev/null
  then
    echo ""
    echo "===================================="
    echo "Mirroring from unraid to $device2"
    $mirror /mnt/user/media/ROMs/ pi@$device2:/home/pi/RetroPie/roms/
    echo "===================================="
  fi
}

usage() {
   # Display Help
   echo "Sync rom, bios, and config folders from retropie devices with my unraid shares."
   echo "Using no options will do a pull then a push to make sure all files are backed up"
   echo "and the same in all locations. If any of the retropie devices are unreachable"
   echo "it will skip those devices."
   echo
   echo "Syntax: romSync [--push | --pull | --help]"
   echo "options:"
   echo "pull     Sync roms, bios, and config folders from devices to unraid"
   echo "push     Mirrors roms folder from unraid to devices"
   echo "help     Print this help"
   echo
}

### Main ###
if [ "$1" = "" ]; then
    pull
    push
else
    while [ "$1" != "" ]; do
    case $1 in
        --push )      shift
                      echo "=============== Push ==============="
                      echo ""
                      push
                      ;;
        --pull )      echo "=============== Pull ==============="
                      echo ""
                      pull
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
