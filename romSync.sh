#!/bin/bash

### Variables ###
piboy='piboy'
gpi='gpi2'
mister='MiSTer'
unraid_games='/mnt/user/games'
retropie_home='/home/pi/RetroPie'
mister_sd='/media/fat'
sync="rsync -rti --update"
mirror="rsync -rti --del"
mirror_mister_roms="rsync -ri --del --exclude '*.rom'"
mirror_exclude="rsync -rti --del --exclude-from=/mnt/user/appdata/romSync/exclude.txt"
sync="rsync -rti --update"

### Functions ###

saves() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $piboy"
    $sync pi@$piboy:$retropie_home/saves/ $unraid_games/retroarch/saves/
    $sync pi@$piboy:$retropie_home/savestates/ $unraid_games/retroarch/savestates/
    $sync pi@$piboy:$retropie_home/screenshots/ $unraid_games/retroarch/screenshots/
    echo ""
    echo "--> Mirroing saves and screenshots back to $piboy"
    $mirror $unraid_games/retroarch/saves/ pi@$piboy:$retropie_home/saves/
    $mirror $unraid_games/retroarch/savestates/ pi@$piboy:$retropie_home/savestates/
    $mirror $unraid_games/retroarch/screenshots/ pi@$piboy:$retropie_home/screenshots/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $gpi"
    $sync pi@$gpi:$retropie_home/saves/ $unraid_games/retroarch/saves/
    $sync pi@$gpi:$retropie_home/savestates/ $unraid_games/retroarch/savestates/
    $sync pi@$gpi:$retropie_home/screenshots/ $unraid_games/retroarch/screenshots/
    echo ""
    echo "--> Mirroing saves and screenshots back to $gpi"
    $mirror $unraid_games/retroarch/saves/ pi@$gpi:$retropie_home/saves/
    $mirror $unraid_games/retroarch/savestates/ pi@$gpi:$retropie_home/savestates/
    $mirror $unraid_games/retroarch/screenshots/ pi@$gpi:$retropie_home/screenshots/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $mister"
    $sync root@$mister:$mister_sd/saves/ $unraid_games/mister/saves/
    $sync root@$mister:$mister_sd/savestates/ $unraid_games/mister/savestates
    $sync root@$mister:$mister_sd/screenshots/ $unraid_games/mister/screenshots
    echo ""
    echo "--> Mirroring saves and screenshots back to $mister"
    $mirror $unraid_games/mister/saves/ root@$mister:$mister_sd/saves/
    $mirror $unraid_games/mister/savestates/ root@$mister:$mister_sd/savestates/
    $mirror $unraid_games/mister/screenshots/ root@$mister:$mister_sd/screenshots/
  fi
}

roms() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Mirroring roms from unraid to $piboy"
    $mirror_exclude $unraid_games/roms/ pi@$piboy:$retropie_home/roms/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Mirroring roms from unraid to $gpi"
    $mirror_exclude $unraid_games/roms/ pi@$gpi:$retropie_home/roms/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Mirroring roms from unraid to $mister"
    $mirror_mister_roms $unraid_games/roms/atari2600/ root@$mister:$mister_sd/games/ATARI2600/
    $mirror_mister_roms $unraid_games/roms/atarilynx/ root@$mister:$mister_sd/games/AtariLynx/
    $mirror_mister_roms $unraid_games/roms/gamegear/ root@$mister:$mister_sd/games/SMS/gamegear/
    $mirror_mister_roms $unraid_games/roms/gb/ root@$mister:$mister_sd/games/GAMEBOY/gb/
    $mirror_mister_roms $unraid_games/roms/gbc/ root@$mister:$mister_sd/games/GAMEBOY/gbc/
    $mirror_mister_roms $unraid_games/roms/gba/ root@$mister:$mister_sd/games/GBA/
    $mirror_mister_roms $unraid_games/roms/megadrive/ root@$mister:$mister_sd/games/Genesis/
    $mirror_mister_roms $unraid_games/roms/nes/ root@$mister:$mister_sd/games/NES/
    $mirror_mister_roms $unraid_games/roms/pcengine/ root@$mister:$mister_sd/games/TGFX16/
    $mirror_mister_roms $unraid_games/roms/pcenginecd/ root@$mister:$mister_sd/games/TGFX16-CD/
    $mirror_mister_roms $unraid_games/roms/segacd/ root@$mister:$mister_sd/games/MegaCD/
    $mirror_mister_roms $unraid_games/roms/snes/ root@$mister:$mister_sd/games/SNES/
  fi
}

usage() {
   # Display Help
   echo "Sync ROMs and saves from retropie devices with my unraid shares."
   echo "Using no options will do a pull then a push to make sure all files are synced"
   echo "and the same in all locations. If any of the devices are unreachable"
   echo "it will skip those devices."
   echo
   echo "Syntax: romSync [--saves | --roms | --help]"
   echo "options:"
   echo "saves    Sync saves and screenshots folders from devices to unraid and back"
   echo "roms     Mirrors roms folder from unraid to devices"
   echo "help     Print this help"
   echo
}

### Main ###
if [ "$1" = "" ]; then
  saves
  roms
else
  while [ "$1" != "" ]; do
  case $1 in
    --saves )      shift
                  echo "--> Saves"
                  saves
                  echo ""
                  ;;
    --roms )      echo "--> ROMs"
                  roms
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
