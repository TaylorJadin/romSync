#!/bin/bash

### Variables ###
mister='mister.home.jadin.me'
miyoo='192.168.1.243'
unraid_games='/mnt/user/games'
mister_sd='/media/fat'
miyoo_mount='/tmp/miyoo'
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
  else
    echo ""
    echo "$mister not online."
  fi

  if ping -c 1 $miyoo &> /dev/null
  then
    echo ""
    echo "--> Mounting $miyoo samba share"
    mkdir -p $miyoo_mount/Saves
    mkdir -p $miyoo_mount/Screenshots
    mount -t cifs //$miyoo/Saves $miyoo_mount/Saves -o username=onion,password=onion
    mount -t cifs //$miyoo/Screenshots $miyoo_mount/Screenshots -o username=onion,password=onion
    if [ -e "/tmp/miyoo/Saves/README.txt" ];
    then
      echo ""
      echo "--> Backing up saves and screenshots from $miyoo"
      $save_sync $miyoo_mount/Saves/ $unraid_games/miyoo/saves/
      $save_sync $miyoo_mount/Screenshots/ $unraid_games/miyoo/screenshots/
      echo ""
      echo "--> Updating $miyoo with missing saves"
      $save_sync $unraid_games/miyoo/saves/  $miyoo_mount/Saves/
      $save_sync $unraid_games/miyoo/screenshots/ $miyoo_mount/Screenshots/
    else
      echo "Problem mounting samba share."
    fi
    echo ""
    echo "--> Unmounting $miyoo samba share"
    umount $miyoo_mount/Saves
    umount $miyoo_mount/Screenshots
    rmdir $miyoo_mount/Saves
    rmdir $miyoo_mount/Screenshots
    rmdir $miyoo_mount
  else
    echo ""
    echo "$miyoo not online."
  fi
}

roms() {
  if ping -c 1 $mister &> /dev/null
  then
    echo ""
    echo "--> Copying roms from unraid to $mister"
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
    $rom_copy $unraid_games/roms/wonderswan/ root@$mister:$mister_sd/games/WonderSwan/
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

