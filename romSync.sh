#!/bin/bash

### Variables ###
piboy='piboy'
gpi='gpi'
mister='MiSTer'
unraid_games='/mnt/user/games'
retropie_home='/home/pi/RetroPie'
mister_sd='/media/fat'
sync="rsync --update -rPt --exclude-from=/mnt/user/appdata/romSync/exclude.txt"
mirror="rsync -rPt --del --exclude-from=/mnt/user/appdata/romSync/exclude.txt"

### Functions ###

pull() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $piboy"
    $sync pi@$piboy:$retropie_home/saves/ $unraid_games/retroarch/saves/
    $sync pi@$piboy:$retropie_home/savestates/ $unraid_games/retroarch/savestates/
    $sync pi@$piboy:$retropie_home/screenshots/ $unraid_games/retroarch/screenshots/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $gpi"
    $sync pi@$gpi:$retropie_home/saves/ $unraid_games/retroarch/saves/
    $sync pi@$gpi:$retropie_home/savestates/ $unraid_games/retroarch/savestates/
    $sync pi@$gpi:$retropie_home/screenshots/ $unraid_games/retroarch/screenshots/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $mister"
    $sync root@$mister:$mister_sd/saves/ $unraid_games/mister/saves/
    $sync root@$mister:$mister_sd/savestates/ $unraid_games/mister/savestates
    $sync root@$mister:$mister_sd/screenshots/ $unraid_games/mister/screenshots
  fi
}

push() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Mirroring from unraid to $piboy"
    $mirror $unraid_games/roms/ pi@$piboy:$retropie_home/roms/
    echo ""
    echo "--> Mirroing saves and screenshots to $piboy"
    $mirror $unraid_games/retroarch/saves/ pi@$piboy:$retropie_home/saves/
    $mirror $unraid_games/retroarch/savestates/ pi@$piboy:$retropie_home/savestates/
    $mirror $unraid_games/retroarch/screenshots/ pi@$piboy:$retropie_home/screenshots/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Mirroring from unraid to $gpi"
    $mirror $unraid_games/roms/ pi@$gpi:$retropie_home/roms/
    echo ""
    echo "--> Mirroing saves and screenshots to $gpi"
    $mirror $unraid_games/retroarch/saves/ pi@$gpi:$retropie_home/saves/
    $mirror $unraid_games/retroarch/savestates/ pi@$gpi:$retropie_home/savestates/
    $mirror $unraid_games/retroarch/screenshots/ pi@$gpi:$retropie_home/screenshots/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Mirroring from unraid to $mister"
    $mirror $unraid_games/roms/ root@$mister:$mister_sd/unraid_roms/
    echo ""
    echo "--> Mirroring saves and screenshots to $mister"
    $mirror $unraid_games/mister/saves/ root@$mister:$mister_sd/saves/
    $mirror $unraid_games/mister/savestates/ root@$mister:$mister_sd/savestates/
    $mirror $unraid_games/mister/screenshots/ root@$mister:$mister_sd/screenshots/
  fi
}

usage() {
   # Display Help
   echo "Sync ROMs and saves from retropie devices with my unraid shares."
   echo "Using no options will do a pull then a push to make sure all files are synced"
   echo "and the same in all locations. If any of the devices are unreachable"
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
