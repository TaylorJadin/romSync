#!/bin/bash

### Variables ###
mister='mister.home.jadin.me'
mister_sd='root@mister.home.jadin.me:/media/fat'
deck='deck.home.jadin.me'
deck_storage='deck@deck.home.jadin.me:/home/deck/Emulation'
miyoo='miyoo.home.jadin.me'
miyoo_sd='/tmp/miyoo'
taylorpc='pc.home.jadin.me'
taylorpc_share='/tmp/taylorpc'
unraid_games='/mnt/user/games'
save_sync="rsync -rLi --times --update"
rom_copy="rsync -rLi --ignore-existing --exclude-from=/mnt/user/appdata/romSync/exclude.txt"

### Functions ###

update() {
  cd /mnt/user/appdata/romSync && git pull
}

saves() {
  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Backup up computer cores"
    $save_sync $mister_sd/games/AO486/ $unraid_games/mister/games/AO486/
    $save_sync $mister_sd/games/MACPLUS/ $unraid_games/mister/games/MACPLUS/
    echo ""
    echo "--> Backing up saves and screenshots from $mister"
    $save_sync $mister_sd/saves/ $unraid_games/mister/saves/
    $save_sync $mister_sd/savestates/ $unraid_games/mister/savestates/
    $save_sync $mister_sd/screenshots/ $unraid_games/mister/screenshots/
    echo ""
    echo "--> Updating $mister with missing saves"
    $save_sync $unraid_games/mister/saves/ $mister_sd/saves/
    $save_sync $unraid_games/mister/savestates/ $mister_sd/savestates/
    # Fix Permissions
    chmod -R 777 $unraid_games/mister
  fi

  if ping -c 1 $deck &> /dev/null
  then
    echo ""
    echo "--> Backing up saves from $deck"
    $save_sync $deck_storage/saves/ $unraid_games/deck/saves/
    echo ""
    echo "--> Updating $deck with missing saves"
    $save_sync $unraid_games/deck/saves/ $deck_storage/saves/
    # Fix Permissions
    chmod -R 777 $unraid_games/deck
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
      $save_sync $miyoo_sd/Saves/CurrentProfile/saves/ $unraid_games/miyoo/saves/
      $save_sync $miyoo_sd/Saves/CurrentProfile/states/ $unraid_games/miyoo/states/
      $save_sync $miyoo_sd/Screenshots/ $unraid_games/miyoo/screenshots/
      echo ""
      echo "--> Updating $miyoo with missing saves"
      $save_sync $unraid_games/miyoo/saves/ $miyoo_sd/Saves/CurrentProfile/saves/
    else
      echo "Problem mounting samba share."
    fi
    echo ""
    echo "--> Unmounting $miyoo samba share"
    umount $miyoo_sd
    rmdir $miyoo_sd
    # Fix Permissions
    chmod -R 777 $unraid_games/miyoo
  fi

  if ping -c 1 $taylorpc &> /dev/null
  then
    echo ""
    echo "--> Mounting $taylorpc samba share"
    mkdir -p $taylorpc_share
    mount -t cifs //$taylorpc/Emulation $taylorpc_share -o username=smbguest,password=smbguest
    if [ -e "$taylorpc_share/saves/.hash" ];
    then
      echo ""
      echo "--> Backing up saves and screenshots from $taylorpc"
      $save_sync $taylorpc_share/Saves/ $unraid_games/taylorpc/Saves/
      echo ""
      echo "--> Updating $taylorpc with missing saves"
      $save_sync $unraid_games/taylorpc/Saves/ $taylorpc_share/Saves/
    else
      echo "Problem mounting samba share."
    fi
    echo ""
    echo "--> Unmounting $taylorpc samba share"
    umount $taylorpc_share
    rmdir $taylorpc_share
    # Fix Permissions
    chmod -R 777 $unraid_games/taylorpc
  fi
}

roms() {
  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Copying roms to $mister"
    $rom_copy $unraid_games/roms/atari2600/ $mister_sd/games/ATARI2600/
    $rom_copy $unraid_games/roms/atari5200/ $mister_sd/games/ATARI5200/
    $rom_copy $unraid_games/roms/atari7800/ $mister_sd/games/ATARI7800/
    $rom_copy $unraid_games/roms/atarilynx/ $mister_sd/games/AtariLynx/
    $rom_copy $unraid_games/roms/gamegear/ $mister_sd/games/GameGear/
    $rom_copy $unraid_games/roms/gb/ $mister_sd/games/GAMEBOY/
    $rom_copy $unraid_games/roms/gbc/ $mister_sd/games/GBC/
    $rom_copy $unraid_games/roms/gba/ $mister_sd/games/GBA/
    $rom_copy $unraid_games/roms/genesis/ $mister_sd/games/Genesis/
    $rom_copy $unraid_games/roms/mastersystem/ $mister_sd/games/SMS/
    $rom_copy $unraid_games/roms/n64/ $mister_sd/games/N64/
    $rom_copy $unraid_games/roms/neogeo_mister/ $mister_sd/games/NEOGEO/
    $rom_copy $unraid_games/roms/nes/ $mister_sd/games/NES/
    $rom_copy $unraid_games/roms/sega32x/ $mister_sd/games/S32X/
    $rom_copy $unraid_games/roms/snes/ $mister_sd/games/SNES/
    $rom_copy $unraid_games/roms/tg16/ $mister_sd/games/TGFX16/
    $rom_copy $unraid_games/roms/wonderswan/ $mister_sd/games/WonderSwan/
  fi

  if ping -c 1 $deck &> /dev/null
  then
    echo ""
    echo "--> Copying froms to $deck"
    $rom_copy $unraid_games/roms/ $deck_storage/roms/
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
      $rom_copy $unraid_games/roms/neogeo/ $miyoo_sd/Roms/NEOGEO/
      $rom_copy $unraid_games/roms/nes/ $miyoo_sd/Roms/FC/
      $rom_copy $unraid_games/roms/sega32x/ $miyoo_sd/Roms/THIRTYTWOX/
      $rom_copy $unraid_games/roms/snes/ $miyoo_sd/Roms/SFC/
      $rom_copy $unraid_games/roms/tg16/ $miyoo_sd/Roms/PCE/
    else
      echo "Problem mounting samba share."
    fi
    echo ""
    echo "--> Unmounting $miyoo samba share"
    umount $miyoo_sd
    rmdir $miyoo_sd
  fi

  if ping -c 1 $taylorpc &> /dev/null
  then
    echo ""
    echo "--> Mounting $taylorpc samba share"
    mkdir -p $taylorpc_share
    mount -t cifs //$taylorpc/Emulation $taylorpc_share -o username=smbguest,password=smbguest
    if [ -e "$taylorpc_share/saves/.hash" ];
    then
      echo ""
      echo "--> Copying roms to $taylorpc"
      $rom_copy $unraid_games/roms/ $taylorpc_share/roms/
    else
      echo "Problem mounting samba share."
    fi
    echo ""
    echo "--> Unmounting $taylorpc samba share"
    umount $taylorpc_share
    rmdir $taylorpc_share
  fi
}

usage() {
   # Display Help
   echo "Sync ROMs and saves from various devices with my unraid shares."
   echo "Using no flags will will first sync saves then roms. If any of"
   echo "the devices are unreachable it will skip those devices."
   echo
   echo "Syntax: romSync [--roms | --saves | --update | --help]"
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
    -u | --update) shift
                  echo "--> Pulling updates from GitHub"
                  update
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

