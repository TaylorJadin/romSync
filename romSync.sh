#!/bin/bash

### Variables ###
mister='mister.home.jadin.me'
miyoo='miyoo.home.jadin.me'
unraid_games='/mnt/user/games'
mister_sd='/media/fat'
miyoo_sd='/tmp/miyoo'
save_sync="rsync -ri --times --copy-links --update"
rom_copy="rsync -ri --ignore-existing --exclude-from=/mnt/user/appdata/romSync/exclude.txt"

### Functions ###

saves() {
  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Backing up saves and screenshots from $mister"
    $save_sync root@$mister:$mister_sd/saves/ $unraid_games/mister/saves/
    $save_sync root@$mister:$mister_sd/savestates/ $unraid_games/mister/savestates/
    $save_sync root@$mister:$mister_sd/screenshots/ $unraid_games/mister/screenshots/
    echo ""
    echo "--> Updating $mister with missing saves"
    $save_sync $unraid_games/mister/saves/ root@$mister:$mister_sd/saves/
    $save_sync $unraid_games/mister/savestates/ root@$mister:$mister_sd/savestates/
  fi

  if ping -c 1 $miyoo &> /dev/null
  then
    echo ""
    echo "--> Mounting $miyoo samba share"
    mkdir -p $miyoo_sd
    mount -t cifs //$miyoo/__sdcard $miyoo_sd -o username=onion,password=onion
    if [ -e "$miyoo_sd/system.json" ];
    then
      echo ""
      echo "--> Backing up saves and screenshots from $miyoo"
      $save_sync $miyoo_sd/Saves/ $unraid_games/miyoo/Saves/
      $save_sync $miyoo_sd/Screenshots/ $unraid_games/miyoo/Screenshots/
      echo ""
      echo "--> Updating $miyoo with missing saves"
      $save_sync $unraid_games/miyoo/Saves/ $miyoo_sd/Saves/
      $save_sync $unraid_games/miyoo/Screenshots/ $miyoo_sd/Screenshots/
    else
      echo "Problem mounting samba share."
    fi
    echo ""
    echo "--> Unmounting $miyoo samba share"
    umount $miyoo_sd
    rmdir $miyoo_sd
  fi
}

roms() {
  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Copying roms to $mister"
    $rom_copy $unraid_games/roms/atari2600/ root@$mister:$mister_sd/games/ATARI2600/
    $rom_copy $unraid_games/roms/atari5200/ root@$mister:$mister_sd/games/ATARI5200/
    $rom_copy $unraid_games/roms/atari7800/ root@$mister:$mister_sd/games/ATARI7800/
    $rom_copy $unraid_games/roms/atarilynx/ root@$mister:$mister_sd/games/AtariLynx/
    $rom_copy $unraid_games/roms/gamegear/ root@$mister:$mister_sd/games/GameGear/
    $rom_copy $unraid_games/roms/gb/ root@$mister:$mister_sd/games/GAMEBOY/
    $rom_copy $unraid_games/roms/gbc/ root@$mister:$mister_sd/games/GBC/
    $rom_copy $unraid_games/roms/gba/ root@$mister:$mister_sd/games/GBA/
    $rom_copy $unraid_games/roms/genesis/ root@$mister:$mister_sd/games/Genesis/
    $rom_copy $unraid_games/roms/mastersystem/ root@$mister:$mister_sd/games/SMS/
    $rom_copy $unraid_games/roms/n64/ root@$mister:$mister_sd/games/N64/
    $rom_copy $unraid_games/roms/neogeo/ root@$mister:$mister_sd/games/NEOGEO/
    $rom_copy $unraid_games/roms/nes/ root@$mister:$mister_sd/games/NES/
    $rom_copy $unraid_games/roms/sega32x/ root@$mister:$mister_sd/games/S32X/
    $rom_copy $unraid_games/roms/snes/ root@$mister:$mister_sd/games/SNES/
    $rom_copy $unraid_games/roms/tgfx16/ root@$mister:$mister_sd/games/TGFX16/
    $rom_copy $unraid_games/roms/wonderswan/ root@$mister:$mister_sd/games/WonderSwan/
  fi

  if ping -c 1 $miyoo &> /dev/null
  then
    echo ""
    echo "--> Mounting $miyoo samba share"
    mkdir -p $miyoo_sd
    mount -t cifs //$miyoo/__sdcard $miyoo_sd -o username=onion,password=onion
    if [ -e "$miyoo_sd/system.json" ];
    then
      echo ""
      echo "--> Copying roms to $miyoo"
      $rom_copy $unraid_games/roms/atari2600/ $miyoo_sd/Roms/ATARI/
      $rom_copy $unraid_games/roms/atari5200/ $miyoo_sd/Roms/FIFTYTWOHUNDRED/
      $rom_copy $unraid_games/roms/atari7800/ $miyoo_sd/Roms/SEVENTYEIGHTHUNDRED/
      $rom_copy $unraid_games/roms/atarilynx/ $miyoo_sd/Roms/LYNX/
      $rom_copy $unraid_games/roms/gamegear/ $miyoo_sd/Roms/GG/
      $rom_copy $unraid_games/roms/gb/ $miyoo_sd/Roms/GB/
      $rom_copy $unraid_games/roms/gbc/ $miyoo_sd/Roms/GBC/
      $rom_copy $unraid_games/roms/gba/ $miyoo_sd/Roms/GBA/
      $rom_copy $unraid_games/roms/genesis/ $miyoo_sd/Roms/MD/
      $rom_copy $unraid_games/roms/mastersystem/ $miyoo_sd/Roms/MS/
      $rom_copy $unraid_games/roms/miyoo_ports/ $miyoo_sd/Roms/PORTS/
      $rom_copy $unraid_games/roms/neogeo/ $miyoo_sd/Roms/NEOGEO/
      $rom_copy $unraid_games/roms/nes/ $miyoo_sd/Roms/FC/
      $rom_copy $unraid_games/roms/sega32x/ $miyoo_sd/Roms/THIRTYTWOX/
      $rom_copy $unraid_games/roms/snes/ $miyoo_sd/Roms/SFC/
      $rom_copy $unraid_games/roms/tgfx16/ $miyoo_sd/Roms/PCE/
    else
      echo "Problem mounting samba share."
    fi
    echo ""
    echo "--> Unmounting $miyoo samba share"
    umount $miyoo_sd
    rmdir $miyoo_sd
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

