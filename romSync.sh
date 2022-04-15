#!/bin/bash

### Variables ###
piboy='piboy'
gpi='gpi2'
mister='MiSTer'
unraid_games='/mnt/user/games'
retropie_home='/home/pi/RetroPie'
mister_sd='/media/fat'
save_sync="rsync -ri --times --update"
rom_copy="rsync -ri --ignore-existing"

### Functions ###

mirror() {
  rom_copy="rsync -ri --delete"
}

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
}

roms() {
  if ping -c 1 $piboy &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $piboy"
    $rom_copy $unraid_games/roms/atari2600/ pi@$piboy:$retropie_home/roms/atari2600/
    $rom_copy $unraid_games/roms/atarilynx/ pi@$piboy:$retropie_home/roms/atarilynx/
    $rom_copy $unraid_games/roms/famicom/ pi@$piboy:$retropie_home/roms/famicom/
    $rom_copy $unraid_games/roms/fba/ pi@$piboy:$retropie_home/roms/fba/
    $rom_copy $unraid_games/roms/gamegear/ pi@$piboy:$retropie_home/roms/gamegear/
    $rom_copy $unraid_games/roms/gb/ pi@$piboy:$retropie_home/roms/gb/
    $rom_copy $unraid_games/roms/gba/ pi@$piboy:$retropie_home/roms/gba/
    $rom_copy $unraid_games/roms/gbc/ pi@$piboy:$retropie_home/roms/gbc/
    $rom_copy $unraid_games/roms/mame-libretro/ pi@$piboy:$retropie_home/roms/mame-libretro/
    $rom_copy $unraid_games/roms/mastersystem/ pi@$piboy:$retropie_home/roms/mastersystem/
    $rom_copy $unraid_games/roms/megadrive/ pi@$piboy:$retropie_home/roms/megadrive/
    $rom_copy $unraid_games/roms/n64/ pi@$piboy:$retropie_home/roms/n64/
    $rom_copy $unraid_games/roms/neogeo/ pi@$piboy:$retropie_home/roms/neogeo/
    $rom_copy $unraid_games/roms/nes/ pi@$piboy:$retropie_home/roms/nes/
    $rom_copy $unraid_games/roms/ngpc/ pi@$piboy:$retropie_home/roms/ngpc/
    $rom_copy $unraid_games/roms/pcengine/ pi@$piboy:$retropie_home/roms/pcengine/
    $rom_copy $unraid_games/roms/sega32x/ pi@$piboy:$retropie_home/roms/sega32x/
    $rom_copy $unraid_games/roms/snes/ pi@$piboy:$retropie_home/roms/snes/
  fi

  if ping -c 1 $gpi &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $gpi"
    $rom_copy $unraid_games/roms/atari2600/ pi@$gpi:$retropie_home/roms/atari2600/
    $rom_copy $unraid_games/roms/atarilynx/ pi@$gpi:$retropie_home/roms/atarilynx/
    $rom_copy $unraid_games/roms/famicom/ pi@$gpi:$retropie_home/roms/famicom/
    $rom_copy $unraid_games/roms/fba/ pi@$gpi:$retropie_home/roms/fba/
    $rom_copy $unraid_games/roms/gamegear/ pi@$gpi:$retropie_home/roms/gamegear/
    $rom_copy $unraid_games/roms/gb/ pi@$gpi:$retropie_home/roms/gb/
    $rom_copy $unraid_games/roms/gba/ pi@$gpi:$retropie_home/roms/gba/
    $rom_copy $unraid_games/roms/gbc/ pi@$gpi:$retropie_home/roms/gbc/
    $rom_copy $unraid_games/roms/mame-libretro/ pi@$gpi:$retropie_home/roms/mame-libretro/
    $rom_copy $unraid_games/roms/mastersystem/ pi@$gpi:$retropie_home/roms/mastersystem/
    $rom_copy $unraid_games/roms/megadrive/ pi@$gpi:$retropie_home/roms/megadrive/
    $rom_copy $unraid_games/roms/n64/ pi@$gpi:$retropie_home/roms/n64/
    $rom_copy $unraid_games/roms/neogeo/ pi@$gpi:$retropie_home/roms/neogeo/
    $rom_copy $unraid_games/roms/nes/ pi@$gpi:$retropie_home/roms/nes/
    $rom_copy $unraid_games/roms/ngpc/ pi@$gpi:$retropie_home/roms/ngpc/
    $rom_copy $unraid_games/roms/pcengine/ pi@$gpi:$retropie_home/roms/pcengine/
    $rom_copy $unraid_games/roms/sega32x/ pi@$gpi:$retropie_home/roms/sega32x/
    $rom_copy $unraid_games/roms/snes/ pi@$gpi:$retropie_home/roms/snes/
  fi

  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $mister"
    $rom_copy $unraid_games/roms/atari800/ root@$mister:$mister_sd/games/ATARI800/
    $rom_copy $unraid_games/roms/atari2600/ root@$mister:$mister_sd/games/ATARI2600/
    $rom_copy $unraid_games/roms/atari5200/ root@$mister:$mister_sd/games/ATARI5200/
    $rom_copy $unraid_games/roms/atari7800/ root@$mister:$mister_sd/games/ATARI7800/
    $rom_copy $unraid_games/roms/atarilynx/ root@$mister:$mister_sd/games/AtariLynx/
    $rom_copy $unraid_games/roms/c64/ root@$mister:$mister_sd/games/c64/
    $rom_copy $unraid_games/roms/famicom/ root@$mister:$mister_sd/games/NES/famicom/
    $rom_copy $unraid_games/roms/gamegear/ root@$mister:$mister_sd/games/SMS/gamegear/
    $rom_copy $unraid_games/roms/gb/ root@$mister:$mister_sd/games/GAMEBOY/gb/
    $rom_copy $unraid_games/roms/gbc/ root@$mister:$mister_sd/games/GAMEBOY/gbc/
    $rom_copy $unraid_games/roms/gba/ root@$mister:$mister_sd/games/GBA/
    $rom_copy $unraid_games/roms/mastersystem/ root@$mister:$mister_sd/games/SMS/mastersystem/
    $rom_copy $unraid_games/roms/macplus/ root@$mister:$mister_sd/games/MACPLUS/
    $rom_copy $unraid_games/roms/megadrive/ root@$mister:$mister_sd/games/Genesis/
    $rom_copy $unraid_games/roms/neogeo_mister/ root@$mister:$mister_sd/games/NEOGEO/
    $rom_copy $unraid_games/roms/nes/ root@$mister:$mister_sd/games/NES/nes/
    $rom_copy $unraid_games/roms/pc/ root@$mister:$mister_sd/games/AO486/
    $rom_copy $unraid_games/roms/pcengine/ root@$mister:$mister_sd/games/TGFX16/
    $rom_copy $unraid_games/roms/pcenginecd/ root@$mister:$mister_sd/games/TGFX16-CD/
    $rom_copy $unraid_games/roms/segacd/ root@$mister:$mister_sd/games/MegaCD/
    $rom_copy $unraid_games/roms/snes/ root@$mister:$mister_sd/games/SNES/
    $rom_copy $unraid_games/roms/wonderswan/ root@$mister:$mister_sd/games/WonderSwan/
  fi
}

usage() {
   # Display Help
   echo "Sync ROMs and saves from retropie devices with my unraid shares."
   echo "Using no flags will will first sync saves then roms. If any of"
   echo "the devices are unreachable it will skip those devices."
   echo
   echo "Syntax: romSync [--mirror | --help]"
   echo "options:"
   echo "mirror   Use --delete flag when rsyncing roms"
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
    --mirror )    shift
                  echo "--> Mirror"
                  saves
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
