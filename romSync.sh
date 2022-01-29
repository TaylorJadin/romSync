#!/bin/bash

### Variables ###
piboy='piboy'
gpi='gpi2'
mister='MiSTer'
unraid_games='/mnt/user/games'
retropie_home='/home/pi/RetroPie'
mister_sd='/media/fat'
sync="rsync -ri --times --update"
mirror="rsync -ri --del --ignore-existing --exclude-from=/mnt/user/appdata/romSync/exclude.txt"

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
    $mirror $unraid_games/roms/atari2600/ pi@$piboy:$retropie_home/roms/atari2600/
    $mirror $unraid_games/roms/atarilynx/ pi@$piboy:$retropie_home/roms/atarilynx/
    $mirror $unraid_games/roms/famicom/ pi@$piboy:$retropie_home/roms/famicom/
    $mirror $unraid_games/roms/fba/ pi@$piboy:$retropie_home/roms/fba/
    $mirror $unraid_games/roms/gamegear/ pi@$piboy:$retropie_home/roms/gamegear/
    $mirror $unraid_games/roms/gb/ pi@$piboy:$retropie_home/roms/gb/
    $mirror $unraid_games/roms/gba/ pi@$piboy:$retropie_home/roms/gba/
    $mirror $unraid_games/roms/gbc/ pi@$piboy:$retropie_home/roms/gbc/
    $mirror $unraid_games/roms/mame-libretro/ pi@$piboy:$retropie_home/roms/mame-libretro/
    $mirror $unraid_games/roms/mastersystem/ pi@$piboy:$retropie_home/roms/mastersystem/
    $mirror $unraid_games/roms/megadrive/ pi@$piboy:$retropie_home/roms/megadrive/
    $mirror $unraid_games/roms/n64/ pi@$piboy:$retropie_home/roms/n64/
    $mirror $unraid_games/roms/neogeo/ pi@$piboy:$retropie_home/roms/neogeo/
    $mirror $unraid_games/roms/nes/ pi@$piboy:$retropie_home/roms/nes/
    $mirror $unraid_games/roms/ngpc/ pi@$piboy:$retropie_home/roms/ngpc/
    $mirror $unraid_games/roms/pcengine/ pi@$piboy:$retropie_home/roms/pcengine/
    $mirror $unraid_games/roms/sega32x/ pi@$piboy:$retropie_home/roms/sega32x/
    $mirror $unraid_games/roms/snes/ pi@$piboy:$retropie_home/roms/snes/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Mirroring roms from unraid to $gpi"
    $mirror $unraid_games/roms/atari2600/ pi@$gpi:$retropie_home/roms/atari2600/
    $mirror $unraid_games/roms/atarilynx/ pi@$gpi:$retropie_home/roms/atarilynx/
    $mirror $unraid_games/roms/famicom/ pi@$gpi:$retropie_home/roms/famicom/
    $mirror $unraid_games/roms/fba/ pi@$gpi:$retropie_home/roms/fba/
    $mirror $unraid_games/roms/gamegear/ pi@$gpi:$retropie_home/roms/gamegear/
    $mirror $unraid_games/roms/gb/ pi@$gpi:$retropie_home/roms/gb/
    $mirror $unraid_games/roms/gba/ pi@$gpi:$retropie_home/roms/gba/
    $mirror $unraid_games/roms/gbc/ pi@$gpi:$retropie_home/roms/gbc/
    $mirror $unraid_games/roms/mame-libretro/ pi@$gpi:$retropie_home/roms/mame-libretro/
    $mirror $unraid_games/roms/mastersystem/ pi@$gpi:$retropie_home/roms/mastersystem/
    $mirror $unraid_games/roms/megadrive/ pi@$gpi:$retropie_home/roms/megadrive/
    $mirror $unraid_games/roms/neogeo/ pi@$gpi:$retropie_home/roms/neogeo/
    $mirror $unraid_games/roms/nes/ pi@$gpi:$retropie_home/roms/nes/
    $mirror $unraid_games/roms/ngpc/ pi@$gpi:$retropie_home/roms/ngpc/
    $mirror $unraid_games/roms/pcengine/ pi@$gpi:$retropie_home/roms/pcengine/
    $mirror $unraid_games/roms/sega32x/ pi@$gpi:$retropie_home/roms/sega32x/
    $mirror $unraid_games/roms/snes/ pi@$gpi:$retropie_home/roms/snes/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Mirroring roms from unraid to $mister"
    $mirror $unraid_games/roms/atari2600/ root@$mister:$mister_sd/games/ATARI2600/
    $mirror $unraid_games/roms/atarilynx/ root@$mister:$mister_sd/games/AtariLynx/
    $mirror $unraid_games/roms/gamegear/ root@$mister:$mister_sd/games/SMS/gamegear/
    $mirror $unraid_games/roms/gb/ root@$mister:$mister_sd/games/GAMEBOY/gb/
    $mirror $unraid_games/roms/gbc/ root@$mister:$mister_sd/games/GAMEBOY/gbc/
    $mirror $unraid_games/roms/gba/ root@$mister:$mister_sd/games/GBA/
    $mirror $unraid_games/roms/megadrive/ root@$mister:$mister_sd/games/Genesis/
    $mirror $unraid_games/roms/neogeo_mister/ root@$mister:$mister_sd/games/NEOGEO/
    $mirror $unraid_games/roms/nes/ root@$mister:$mister_sd/games/NES/
    $mirror $unraid_games/roms/pcengine/ root@$mister:$mister_sd/games/TGFX16/
    $mirror $unraid_games/roms/pcenginecd/ root@$mister:$mister_sd/games/TGFX16-CD/
    $mirror $unraid_games/roms/segacd/ root@$mister:$mister_sd/games/MegaCD/
    $mirror $unraid_games/roms/snes/ root@$mister:$mister_sd/games/SNES/
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
