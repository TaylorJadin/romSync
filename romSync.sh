#!/bin/bash

### Variables ###
gpi='gpi2'
mister='MiSTer'
deck='taylor-deck.local'
unraid_games='/mnt/user/games'
retropie_home='/home/pi/RetroPie'
mister_sd='/media/fat'
deck_emufolder='/home/deck/Emulation'
save_sync="rsync -ri --times --update"
rom_copy="rsync -ri --delete --ignore-existing --exclude-from=/mnt/user/appdata/romSync/exclude.txt"

### Functions ###

saves() {
  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Backing up saves and screenshots from $gpi"
    $save_sync pi@$gpi:$retropie_home/saves/ $unraid_games/retroarch/saves/
    $save_sync pi@$gpi:$retropie_home/savestates/ $unraid_games/retroarch/savestates/
    $save_sync pi@$gpi:$retropie_home/screenshots/ $unraid_games/retroarch/screenshots/
  else
    echo ""
    echo "$gpi not online."
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Backing up saves and screenshots from $mister"
    $save_sync root@$mister:$mister_sd/saves/ $unraid_games/mister/saves/
    $save_sync root@$mister:$mister_sd/savestates/ $unraid_games/mister/savestates
    $save_sync root@$mister:$mister_sd/screenshots/ $unraid_games/mister/screenshots
  else
    echo ""
    echo "$mister not online."
  fi

  if ping -c 1 $deck &> /dev/null
  then
    echo ""
    echo "--> Backing up saves from $deck"
    $save_sync deck@$deck:$deck_emufolder/saves/ $unraid_games/deck/saves/
    $save_sync deck@$deck:$deck_emufolder/storage/ $unraid_games/deck/storage/
  else
    echo ""
    echo "$deck not online."
  fi
  fi
}

roms() {

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
    $rom_copy $unraid_games/roms/Coleco/Colecovision/ deck@$deck:$deck_emufolder/roms/colecovision/
    $rom_copy $unraid_games/roms/Coleco/SG1000/ deck@$deck:$deck_emufolder/roms/sg-1000/
    $rom_copy $unraid_games/roms/GAMEBOY/1\ Game\ Boy/ deck@$deck:$deck_emufolder/roms/gb/
    $rom_copy $unraid_games/roms/GAMEBOY/1\ Game\ Boy\ Color/ deck@$deck:$deck_emufolder/roms/gbc/
    $rom_copy $unraid_games/roms/GBA/ deck@$deck:$deck_emufolder/roms/gba/
    $rom_copy $unraid_games/roms/Genesis/ deck@$deck:$deck_emufolder/roms/genesis/
    $rom_copy $unraid_games/roms/N64/ deck@$deck:$deck_emufolder/roms/n64/
    $rom_copy $unraid_games/roms/NEOGEO/ deck@$deck:$deck_emufolder/roms/neogeo/
    $rom_copy $unraid_games/roms/NeoGeoPocketColor/1\ NGPC\ US\ -\ A-Z/ deck@$deck:$deck_emufolder/roms/ngpc/
    $rom_copy $unraid_games/roms/NeoGeoPocketColor/3\ NGP\ -\ A-Z/ deck@$deck:$deck_emufolder/roms/ngp/
    $rom_copy $unraid_games/roms/NES/ deck@$deck:$deck_emufolder/roms/nes/
    $rom_copy $unraid_games/roms/S32X/ deck@$deck:$deck_emufolder/roms/sega32x/
    $rom_copy $unraid_games/roms/SMS/ deck@$deck:$deck_emufolder/roms/mastersystem/
    $rom_copy $unraid_games/roms/SNES/ deck@$deck:$deck_emufolder/roms/snes/
    $rom_copy $unraid_games/roms/TGFX16/ deck@$deck:$deck_emufolder/roms/tg16/
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
