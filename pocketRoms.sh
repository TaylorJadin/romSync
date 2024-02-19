rom_copy="rsync -ri --ignore-existing --exclude-from=./exclude.txt"
unraid_games=root@unraid.jadin.me:/mnt/user/games/roms

$rom_copy $unraid_games/atari2600/ ./Assets/2600/common/
$rom_copy $unraid_games/atari7800/ ./Assets/7800/common/
$rom_copy $unraid_games/gb/ ./Assets/gb/common/
$rom_copy $unraid_games/gbc/ ./Assets/gbc/common/
$rom_copy $unraid_games/gba/ ./Assets/gba/common/
$rom_copy $unraid_games/genesis/ ./Assets/genesis/common/
$rom_copy $unraid_games/neogeo_mister/ ./Assets/ng/common/
$rom_copy $unraid_games/nes/ ./Assets/nes/common/
$rom_copy $unraid_games/mastersystem/ ./Assets/sms/common/
$rom_copy $unraid_games/snes/ ./Assets/snes/common/
$rom_copy $unraid_games/tgfx16/ ./Assets/pce/common/
$rom_copy $unraid_games/wonderswan/ ./Assets/wonderswan/common/