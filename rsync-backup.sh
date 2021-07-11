#!/bin/zsh

###
# This script reads from ~.rsync-backup to identify paths to sync using rsync
# You can use this to backup specific directories to an external location (such as an external hard drive)
###

backupIFS=$IFS
dotFileName=".rsync-backup"
dotFilePath="$HOME/$dotFileName"

echo $dotFilePath

if [ ! -f "$dotFilePath" ]; then
    echo "" > "$dotFilePath"
fi

while IFS=: read source destination
do
    echo "Backing up $source to $destination"

    rsync -a $source $destination

done < "$dotFilePath"

IFS=$backupIFS

return 0
