#!/bin/bash

### Variables ###
piboy='piboy'
gpi='gpi2'
mister='MiSTer'
deck='steamdeck.lan'
unraid_games='/mnt/user/games'
retropie_home='/home/pi/RetroPie'
mister_sd='/media/fat'
deck_emufolder='/home/deck/Emulation'
save_sync="rsync -ri --times --update"
rom_copy="rsync -ri --ignore-existing --exclude-from=/mnt/user/appdata/romSync/exclude.txt"

### Functions ###

saves() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $piboy"
    $save_sync pi@$piboy:$retropie_home/saves/ $unraid_games/retroarch/saves/
    $save_sync pi@$piboy:$retropie_home/savestates/ $unraid_games/retroarch/savestates/
    $save_sync pi@$piboy:$retropie_home/screenshots/ $unraid_games/retroarch/screenshots/
    echo ""
    echo "--> Syncing saves and screenshots back to $piboy"
    $save_sync $unraid_games/retroarch/saves/ pi@$piboy:$retropie_home/saves/
    $save_sync $unraid_games/retroarch/savestates/ pi@$piboy:$retropie_home/savestates/
    $save_sync $unraid_games/retroarch/screenshots/ pi@$piboy:$retropie_home/screenshots/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $gpi"
    $save_sync pi@$gpi:$retropie_home/saves/ $unraid_games/retroarch/saves/
    $save_sync pi@$gpi:$retropie_home/savestates/ $unraid_games/retroarch/savestates/
    $save_sync pi@$gpi:$retropie_home/screenshots/ $unraid_games/retroarch/screenshots/
    echo ""
    echo "--> Syncing saves and screenshots back to $gpi"
    $save_sync $unraid_games/retroarch/saves/ pi@$gpi:$retropie_home/saves/
    $save_sync $unraid_games/retroarch/savestates/ pi@$gpi:$retropie_home/savestates/
    $save_sync $unraid_games/retroarch/screenshots/ pi@$gpi:$retropie_home/screenshots/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $mister"
    $save_sync root@$mister:$mister_sd/saves/ $unraid_games/mister/saves/
    $save_sync root@$mister:$mister_sd/savestates/ $unraid_games/mister/savestates
    $save_sync root@$mister:$mister_sd/screenshots/ $unraid_games/mister/screenshots
    echo ""
    echo "--> Syncing saves and screenshots back to $mister"
    $save_sync $unraid_games/mister/saves/ root@$mister:$mister_sd/saves/
    $save_sync $unraid_games/mister/savestates/ root@$mister:$mister_sd/savestates/
    $save_sync $unraid_games/mister/screenshots/ root@$mister:$mister_sd/screenshots/
  fi

  if ping -c 1 $deck &> /dev/null
  then
    echo ""
    echo "--> Syncing saves from $deck"
    $save_sync deck@deck:$deck_emufolder/saves/ $unraid_games/deck/saves/
    echo ""
    echo "--> Syncing saves back to $deck"
    $save_sync $unraid_games/deck/saves/ deck@deck:$deck_emufolder/saves/
  fi
}

roms() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $piboy"
    # $rom_copy $unraid_games/roms/SYSTEM/ pi@$piboy:$retropie_home/roms/SYSTEM/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $gpi"
    # $rom_copy $unraid_games/roms/SYSTEM/ pi@$gpi:$retropie_home/roms/SYSTEM/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $mister"
    # $rom_copy $unraid_games/roms/SYSTEM/ root@$mister:$mister_sd/games/SYSTEM/
  fi

  if ping -c 1 $deck &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $deck"
    $rom_copy $unraid_games/roms/ATARI2600/ deck@$deck:$deck_emufolder/roms/atari2600/
    $rom_copy $unraid_games/roms/ATARI5200/ deck@$deck:$deck_emufolder/roms/atari5200/
    $rom_copy $unraid_games/roms/ATARI7800/ deck@$deck:$deck_emufolder/roms/atari7800/
    $rom_copy $unraid_games/roms/AtariJaguar/ deck@$deck:$deck_emufolder/roms/atarijaguar/
    $rom_copy $unraid_games/roms/AtariLynx/ deck@$deck:$deck_emufolder/roms/atarilynx/
    $rom_copy $unraid_games/roms/GAMEBOY/1\ Game\ Boy/ deck@$deck:$deck_emufolder/roms/gb/
    $rom_copy $unraid_games/roms/GAMEBOY/1\ Game\ Boy\ Color/ deck@$deck:$deck_emufolder/roms/gbc/
    $rom_copy $unraid_games/roms/GBA/ deck@$deck:$deck_emufolder/roms/gba/
    $rom_copy $unraid_games/roms/Genesis/ deck@$deck:$deck_emufolder/roms/genesis/
    $rom_copy $unraid_games/roms/N64/ deck@$deck:$deck_emufolder/roms/n64/
  fi
}

usage() {
   # Display Help
   echo "Sync ROMs and saves from retropie devices with my unraid shares."
   echo "Using no flags will will first sync saves then roms. If any of"
   echo "the devices are unreachable it will skip those devices."
   echo
   echo "Syntax: romSync [--roms | --saves | --help]"
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
    -h | --help ) usage
                  exit
                  ;;
    * )           usage
                  exit 1
  esac
  shift
done
fi
