rom_copy="rsync -ri --ignore-existing --exclude-from=./exclude.txt"
unraid_games=/Volumes/games
pocket_sd=/Volumes/PocketSD

$rom_copy $unraid_games/roms/atari2600/ $pocket_sd/Assets/2600/common/
$rom_copy $unraid_games/roms/atari7800/ $pocket_sd/Assets/7800/common/
$rom_copy $unraid_games/roms/gb/ $pocket_sd/Assets/gb/common/
$rom_copy $unraid_games/roms/gbc/ $pocket_sd/Assets/gbc/common/
$rom_copy $unraid_games/roms/gba/ $pocket_sd/Assets/gba/common/
$rom_copy $unraid_games/roms/genesis/ $pocket_sd/Assets/genesis/common/
$rom_copy $unraid_games/roms/neogeo_mister/ $pocket_sd/Assets/ng/common/
$rom_copy $unraid_games/roms/nes/ $pocket_sd/Assets/nes/common/
$rom_copy $unraid_games/roms/mastersystem/ $pocket_sd/Assets/sms/common/
$rom_copy $unraid_games/roms/snes/ $pocket_sd/Assets/snes/common/
$rom_copy $unraid_games/roms/tgfx16/ $pocket_sd/Assets/pce/common/
$rom_copy $unraid_games/roms/wonderswan/ $pocket_sd/Assets/wonderswan/common/