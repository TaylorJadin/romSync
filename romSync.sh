#!/bin/bash

### Variables ###
piboy='piboy'
gpi='gpi'
mister='mister.jadin.me'
unraid_roms='/mnt/user/media/ROMs'
retropie_roms='/home/pi/RetroPie/roms'
mister_roms='/media/fat/games'
sync="rsync --update -rPt --exclude-from=/mnt/user/appdata/romSync/exclude.txt"
mirror="rsync -rPt --del --exclude-from=/mnt/user/appdata/romSync/exclude.txt"

### Functions ###

pull() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Syncing roms from $piboy"
    $sync pi@$piboy:$retropie_roms/ $unraid_roms/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Syncing roms from $gpi"
    $sync pi@$gpi:$retropie_roms/ $unraid_roms/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Syncing roms from $mister"
    $sync root@$mister:$mister_roms/ATARI2600/ $unraid_roms/atari2600/
    $sync root@$mister:$mister_roms/ATARI5200/ $unraid_roms/atari5200/
    $sync root@$mister:$mister_roms/ATARI7800/ $unraid_roms/atari7800/
    $sync root@$mister:$mister_roms/AtariLynx/ $unraid_roms/atarilynx/
    $sync root@$mister:$mister_roms/GAMEBOY/GB/ $unraid_roms/gb/
    $sync root@$mister:$mister_roms/GAMEBOY/GBC/ $unraid_roms/gbc/
    $sync root@$mister:$mister_roms/GBA/ $unraid_roms/gba/
    $sync root@$mister:$mister_roms/Genesis/ $unraid_roms/megadrive/
    $sync root@$mister:$mister_roms/NeoGeo/ $unraid_roms/neogeo/
    $sync root@$mister:$mister_roms/NES/ $unraid_roms/nes/
    $sync root@$mister:$mister_roms/SMS/ $unraid_roms/mastersystem/
    $sync root@$mister:$mister_roms/SNES/ $unraid_roms/snes/
    $sync root@$mister:$mister_roms/TGFX16/ $unraid_roms/pcengine/
  fi
}

push() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Mirroring from unraid to $piboy"
    $mirror $unraid_roms/ pi@$piboy:$retropie_roms/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Mirroring from unraid to $gpi"
    $mirror $unraid_roms/ pi@$gpi:$retropie_roms/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Mirroring from unraid to $mister"
    $mirror $unraid_roms/atari2600/ root@$mister:$mister_roms/ATARI2600/
    $mirror $unraid_roms/atari5200/ root@$mister:$mister_roms/ATARI5200/
    $mirror $unraid_roms/atari7800/ root@$mister:$mister_roms/ATARI7800/
    $mirror $unraid_roms/atarilynx/ root@$mister:$mister_roms/AtariLynx/
    $mirror $unraid_roms/gb/ root@$mister:$mister_roms/GAMEBOY/GB/
    $mirror $unraid_roms/gbc/ root@$mister:$mister_roms/GAMEBOY/GBC/
    $mirror $unraid_roms/gba/ root@$mister:$mister_roms/GBA/
    $mirror $unraid_roms/megadrive/ root@$mister:$mister_roms/Genesis/
    $mirror $unraid_roms/neogeo/ root@$mister:$mister_roms/NeoGeo/
    $mirror $unraid_roms/nes/ root@$mister:$mister_roms/NES/
    $mirror $unraid_roms/mastersystem/ root@$mister:$mister_roms/SMS/
    $mirror $unraid_roms/snes/ root@$mister:$mister_roms/SNES/
    $mirror $unraid_roms/pcengine/ root@$mister:$mister_roms/TGFX16/
  fi
}

usage() {
   # Display Help
   echo "Sync ROMs and saves from retropie devices with my unraid shares."
   echo "Using no options will do a pull then a push to make sure all files are synced"
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
