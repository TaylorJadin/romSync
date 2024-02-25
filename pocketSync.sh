rom_copy="rsync -ri --ignore-existing --exclude-from=./exclude.txt"
save_sync="rsync -ri --times --update"
unraid_games=root@unraid.jadin.me:/mnt/user/games

saves() {
    echo "--> Backing up Memories and Saves from Pocket"
    $save_sync ./Memories/ $unraid_games/pocket/Memories/
    $save_sync ./Saves/ $unraid_games/pocket/Saves/
    echo ""
    echo "--> Updating Pocket with missing saves"
    $save_sync $unraid_games/pocket/Memories/ ./Memories/
    $save_sync $unraid_games/pocket/Saves/ ./Saves/
}

roms() {
    echo ""
    echo "--> Copying roms to Pocket"
    $rom_copy $unraid_games/roms/atari2600/ ./Assets/2600/common/
    $rom_copy $unraid_games/roms/atari7800/ ./Assets/7800/common/
    $rom_copy $unraid_games/roms/gb/ ./Assets/gb/common/
    $rom_copy $unraid_games/roms/gba/ ./Assets/gba/common/
    $rom_copy $unraid_games/roms/gbc/ ./Assets/gbc/common/
    $rom_copy $unraid_games/roms/genesis/ ./Assets/genesis/common/
    $rom_copy $unraid_games/roms/gamegear/ ./Assets/gg/common/
    $rom_copy $unraid_games/roms/neogeo_mister/ ./Assets/ng/common/
    $rom_copy $unraid_games/roms/nes/ ./Assets/nes/common/
    $rom_copy $unraid_games/roms/mastersystem/ ./Assets/sms/common/
    $rom_copy $unraid_games/roms/snes/ ./Assets/snes/common/
    $rom_copy $unraid_games/roms/tgfx16/ ./Assets/pce/common/
    $rom_copy $unraid_games/roms/wonderswan/ ./Assets/wonderswan/common/
}

usage() {
   # Display Help
   echo "Sync ROMs and saves from my Analogue Pocket with my unraid shares."
   echo "Using no flags will will first sync saves then roms."
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
                  update
                  echo "--> Roms"
                  roms
                  echo ""
                  ;;
    -s | --saves) shift
                  update
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