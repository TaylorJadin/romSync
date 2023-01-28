rom_copy="rsync -ri --delete --ignore-existing --exclude-from=./exclude.txt"
unraid_games='/mnt/user/games'
pocket_sd='/Volumes/PocketSD'

$rom_copy $unraid_games/roms/ATARI2600/ $pocket_sd/Assets/atari2600/common/
$rom_copy $unraid_games/roms/ATARI7800/ $pocket_sd/Assets/7800/common/
$rom_copy $unraid_games/roms/Coleco/Colecovision/ $pocket_sd/Assets/colecovision/common/
$rom_copy $unraid_games/roms/Coleco/SG1000/ $pocket_sd/Assets/sg-1000/common/
$rom_copy $unraid_games/roms/GAMEBOY/1\ Game\ Boy/ $pocket_sd/Assets/gb/common/
$rom_copy $unraid_games/roms/GAMEBOY/1\ Game\ Boy\ Color/ $pocket_sd/Assets/gbc/common/
$rom_copy $unraid_games/roms/GBA/ $pocket_sd/Assets/gba/common/
$rom_copy $unraid_games/roms/Genesis/ $pocket_sd/Assets/genesis/common/
$rom_copy $unraid_games/roms/NEOGEO/ $pocket_sd/Assets/ng/common/
$rom_copy $unraid_games/roms/NES/ $pocket_sd/Assets/nes/common/
$rom_copy $unraid_games/roms/SMS/ $pocket_sd/Assets/sms/common/
$rom_copy $unraid_games/roms/SNES/ $pocket_sd/Assets/snes/common/
$rom_copy $unraid_games/roms/TGFX16/ $pocket_sd/Assets/pce/common/
$rom_copy $unraid_games/roms/WonderSwan/1\ WonderSwan\ A-Z/ $pocket_sd/Assets/wonderswan/common/