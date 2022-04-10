#!/bin/bash

### Variables ###
piboy='piboy'
gpi='gpi2'
mister='MiSTer'
unraid_games='/mnt/user/games'
retropie_home='/home/pi/RetroPie'
mister_sd='/media/fat'
sync="rsync -ri --times --update"
copy="rsync -ri --ignore-existing --exclude-from=/mnt/user/appdata/romSync/exclude.txt"

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
    echo "--> Syncing saves and screenshots back to $piboy"
    $sync $unraid_games/retroarch/saves/ pi@$piboy:$retropie_home/saves/
    $sync $unraid_games/retroarch/savestates/ pi@$piboy:$retropie_home/savestates/
    $sync $unraid_games/retroarch/screenshots/ pi@$piboy:$retropie_home/screenshots/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $gpi"
    $sync pi@$gpi:$retropie_home/saves/ $unraid_games/retroarch/saves/
    $sync pi@$gpi:$retropie_home/savestates/ $unraid_games/retroarch/savestates/
    $sync pi@$gpi:$retropie_home/screenshots/ $unraid_games/retroarch/screenshots/
    echo ""
    echo "--> Syncing saves and screenshots back to $gpi"
    $sync $unraid_games/retroarch/saves/ pi@$gpi:$retropie_home/saves/
    $sync $unraid_games/retroarch/savestates/ pi@$gpi:$retropie_home/savestates/
    $sync $unraid_games/retroarch/screenshots/ pi@$gpi:$retropie_home/screenshots/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Syncing saves and screenshots from $mister"
    $sync root@$mister:$mister_sd/saves/ $unraid_games/mister/saves/
    $sync root@$mister:$mister_sd/savestates/ $unraid_games/mister/savestates
    $sync root@$mister:$mister_sd/screenshots/ $unraid_games/mister/screenshots
    echo ""
    echo "--> Syncing saves and screenshots back to $mister"
    $sync $unraid_games/mister/saves/ root@$mister:$mister_sd/saves/
    $sync $unraid_games/mister/savestates/ root@$mister:$mister_sd/savestates/
    $sync $unraid_games/mister/screenshots/ root@$mister:$mister_sd/screenshots/
  fi
}

roms() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $piboy"
    $copy $unraid_games/roms/atari2600/ pi@$piboy:$retropie_home/roms/atari2600/
    $copy $unraid_games/roms/atarilynx/ pi@$piboy:$retropie_home/roms/atarilynx/
    $copy $unraid_games/roms/famicom/ pi@$piboy:$retropie_home/roms/famicom/
    $copy $unraid_games/roms/fba/ pi@$piboy:$retropie_home/roms/fba/
    $copy $unraid_games/roms/gamegear/ pi@$piboy:$retropie_home/roms/gamegear/
    $copy $unraid_games/roms/gb/ pi@$piboy:$retropie_home/roms/gb/
    $copy $unraid_games/roms/gba/ pi@$piboy:$retropie_home/roms/gba/
    $copy $unraid_games/roms/gbc/ pi@$piboy:$retropie_home/roms/gbc/
    $copy $unraid_games/roms/mame-libretro/ pi@$piboy:$retropie_home/roms/mame-libretro/
    $copy $unraid_games/roms/mastersystem/ pi@$piboy:$retropie_home/roms/mastersystem/
    $copy $unraid_games/roms/megadrive/ pi@$piboy:$retropie_home/roms/megadrive/
    $copy $unraid_games/roms/n64/ pi@$piboy:$retropie_home/roms/n64/
    $copy $unraid_games/roms/neogeo/ pi@$piboy:$retropie_home/roms/neogeo/
    $copy $unraid_games/roms/nes/ pi@$piboy:$retropie_home/roms/nes/
    $copy $unraid_games/roms/ngpc/ pi@$piboy:$retropie_home/roms/ngpc/
    $copy $unraid_games/roms/pcengine/ pi@$piboy:$retropie_home/roms/pcengine/
    $copy $unraid_games/roms/sega32x/ pi@$piboy:$retropie_home/roms/sega32x/
    $copy $unraid_games/roms/snes/ pi@$piboy:$retropie_home/roms/snes/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $gpi"
    $copy $unraid_games/roms/atari2600/ pi@$gpi:$retropie_home/roms/atari2600/
    $copy $unraid_games/roms/atarilynx/ pi@$gpi:$retropie_home/roms/atarilynx/
    $copy $unraid_games/roms/famicom/ pi@$gpi:$retropie_home/roms/famicom/
    $copy $unraid_games/roms/fba/ pi@$gpi:$retropie_home/roms/fba/
    $copy $unraid_games/roms/gamegear/ pi@$gpi:$retropie_home/roms/gamegear/
    $copy $unraid_games/roms/gb/ pi@$gpi:$retropie_home/roms/gb/
    $copy $unraid_games/roms/gba/ pi@$gpi:$retropie_home/roms/gba/
    $copy $unraid_games/roms/gbc/ pi@$gpi:$retropie_home/roms/gbc/
    $copy $unraid_games/roms/mame-libretro/ pi@$gpi:$retropie_home/roms/mame-libretro/
    $copy $unraid_games/roms/mastersystem/ pi@$gpi:$retropie_home/roms/mastersystem/
    $copy $unraid_games/roms/megadrive/ pi@$gpi:$retropie_home/roms/megadrive/
    $copy $unraid_games/roms/n64/ pi@$gpi:$retropie_home/roms/n64/
    $copy $unraid_games/roms/neogeo/ pi@$gpi:$retropie_home/roms/neogeo/
    $copy $unraid_games/roms/nes/ pi@$gpi:$retropie_home/roms/nes/
    $copy $unraid_games/roms/ngpc/ pi@$gpi:$retropie_home/roms/ngpc/
    $copy $unraid_games/roms/pcengine/ pi@$gpi:$retropie_home/roms/pcengine/
    $copy $unraid_games/roms/sega32x/ pi@$gpi:$retropie_home/roms/sega32x/
    $copy $unraid_games/roms/snes/ pi@$gpi:$retropie_home/roms/snes/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $mister"
    $copy $unraid_games/roms/atari800/ root@$mister:$mister_sd/games/ATARI800/
    $copy $unraid_games/roms/atari2600/ root@$mister:$mister_sd/games/ATARI2600/
    $copy $unraid_games/roms/atari5200/ root@$mister:$mister_sd/games/ATARI5200/
    $copy $unraid_games/roms/atari7800/ root@$mister:$mister_sd/games/ATARI7800/
    $copy $unraid_games/roms/atarilynx/ root@$mister:$mister_sd/games/AtariLynx/
    $copy $unraid_games/roms/c64/ root@$mister:$mister_sd/games/c64/
    $copy $unraid_games/roms/famicom/ root@$mister:$mister_sd/games/NES/famicom/
    $copy $unraid_games/roms/gamegear/ root@$mister:$mister_sd/games/SMS/gamegear/
    $copy $unraid_games/roms/gb/ root@$mister:$mister_sd/games/GAMEBOY/gb/
    $copy $unraid_games/roms/gbc/ root@$mister:$mister_sd/games/GAMEBOY/gbc/
    $copy $unraid_games/roms/gba/ root@$mister:$mister_sd/games/GBA/
    $copy $unraid_games/roms/mastersystem/ root@$mister:$mister_sd/games/SMS/mastersystem/
    $copy $unraid_games/roms/macplus/ root@$mister:$mister_sd/games/MACPLUS/
    $copy $unraid_games/roms/megadrive/ root@$mister:$mister_sd/games/Genesis/
    $copy $unraid_games/roms/neogeo_mister/ root@$mister:$mister_sd/games/NEOGEO/
    $copy $unraid_games/roms/nes/ root@$mister:$mister_sd/games/NES/nes/
    $copy $unraid_games/roms/pc/ root@$mister:$mister_sd/games/AO486/
    $copy $unraid_games/roms/pcengine/ root@$mister:$mister_sd/games/TGFX16/
    $copy $unraid_games/roms/pcenginecd/ root@$mister:$mister_sd/games/TGFX16-CD/
    $copy $unraid_games/roms/segacd/ root@$mister:$mister_sd/games/MegaCD/
    $copy $unraid_games/roms/snes/ root@$mister:$mister_sd/games/SNES/
    $copy $unraid_games/roms/wonderswan/ root@$mister:$mister_sd/games/WonderSwan/
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
   echo "roms     Copy rom folders from unraid to devices"
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
