{ pkgs }:
pkgs.writeShellScriptBin "backup-config" ''
set -e
MNT=/tmp/__config_backup_mnt

rm -rf $MNT; mkdir $MNT
mount $1 $MNT
cp -rf /etc/nixos/* $MNT/
umount $MNT
rm -rf $MNT
echo "Done"
''
