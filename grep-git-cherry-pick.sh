logOutputTmpFile="tmp.txt"
commitHashOnlyTmpFile="tmp2.txt"
alreadyPickedTmpFile="alreadyPicked.txt"


# Using the other script in this repo, grab the commits we care about
grep-git-log.sh < /dev/stdin > $logOutputTmpFile

# Grab only the hashes from that output
awk -F" " '{ print $1 }' $logOutputTmpFile > $commitHashOnlyTmpFile


# If the "already picked" file doesn't exist, create it
if [ ! -f "$alreadyPickedTmpFile" ]; then
    echo "" > "$alreadyPickedTmpFile"
else
    # If it already exists, then filter things that have already been picked out
    grep -v -x -f $alreadyPickedTmpFile f1 > $commitHashOnlyTmpFile
fi

# While there is input to pick, log that we picked it and attempt to grab!
while read hash;
do
    echo "Attempting to pick $hash"
    echo $hash >> $alreadyPickedTmpFile
    git cherry-pick -m1 $hash

done < $commitHashOnlyTmpFile

rm $logOutputTmpFile $commitHashOnlyTmpFile $alreadyPickedTmpFile
