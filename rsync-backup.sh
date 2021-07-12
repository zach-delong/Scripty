#!/bin/zsh

###
# This script reads from ~.rsync-backup to identify paths to sync using rsync
# You can use this to backup specific directories to an external location (such as an external hard drive)
###

# At the end of the script, we want to reset the IFS to whatever it was before
backupIFS=$IFS
# The name of the file we read directories from
dotFileName=".rsync-backup"
# The path of the file we read directories from
dotFilePath="$HOME/$dotFileName"

# SETTINGS!
# Whether we should back up or restore. Linked to the arguments below.
doBackup=true # By default, backup
doRestore=false

# Parse arguments for flags passed into this program.
for arg in "$@"
do
    echo $arg;
    case $arg in
        "-b" | "--backup")
            echo "Backup selected"
            doBackup=true
            doRestore=false
            ;;
        "-r" | "--restore")
            echo "Restore selected"
            doRestore=true
            doBackup=false
            ;;
        *)
            echo "Invalid option"
            return 1
            ;;
    esac
done

if [ ! -f "$dotFilePath" ]; then
    echo "" > "$dotFilePath"
fi

while IFS=: read source destination
do
    if [ $doBackup = true ]; then
        echo "Backing up $source to $destination"
        rsync -a $source $destination
    fi

    if [ $doRestore = true ]; then
        echo "Restoring $destination to $source"
        rsync -a $destination $source
    fi

done < "$dotFilePath"

IFS=$backupIFS

return 0
