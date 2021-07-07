#!/bin/bash

### Variables ###
piboy='piboy'
gpi='gpi'
mister='mister.jadin.me'
unraid_roms='/mnt/user/media/ROMs/'
retropie_roms='/home/pi/RetroPie/roms/'
sync="rsync -rPt --exclude-from=/mnt/user/appdata/romSync/exclude.txt"
mirror="rsync -rPt --del --exclude-from=/mnt/user/appdata/romSync/exclude.txt"
backup="rsync -ahP --del"

### Functions ###

pull() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Syncing roms from $piboy"
    $sync pi@$piboy:$retropie_roms $unraid_roms
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Syncing roms from $gpi"
    $sync pi@$gpi:$retropie_roms $unraid_roms
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Syncing roms from $mister"
    $sync root@$mister:/media/fat/games/ATARI2600/ /mnt/user/media/ROMs/atari2600/
  fi
}

push() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Mirroring from unraid to $piboy"
    $mirror $unraid_roms pi@$piboy:$retropie_roms
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Mirroring from unraid to $gpi"
    $mirror $unraid_roms pi@$gpi:$retropie_roms
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Mirroring from unraid to $mister"
    $mirror /mnt/user/media/ROMs/atari2600/ root@$mister:/media/fat/games/ATARI2600/
  fi
}

usage() {
   # Display Help
   echo "Sync ROMs and saves from retropie devices with my unraid shares."
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
                      echo "--> Push"
                      push
                      echo ""
                      ;;
        --pull )      echo "--> Pull"
                      pull
                      echo ""
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
