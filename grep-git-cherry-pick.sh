logOutputTmpFile="tmp.txt"
commitHashOnlyTmpFile="tmp2.txt"
alreadyPickedTmpFile="alreadyPicked.txt"


grep-git-log.sh < /dev/stdin > $logOutputTmpFile

awk -F" " '{ print $1 }' $logOutputTmpFile > $commitHashOnlyTmpFile


if [ ! -f "$alreadyPickedTmpFile" ]; then
    echo "" > "$alreadyPickedTmpFile"
else
    grep -v -x -f $alreadyPickedTmpFile f1 > $commitHashOnlyTmpFile
fi

while read hash;
do
    echo "Attempting to pick $hash"
    echo $hash >> $alreadyPickedTmpFile
    git cherry-pick -m1 $hash

done < $commitHashOnlyTmpFile

rm $logOutputTmpFile $commitHashOnlyTmpFile $alreadyPickedTmpFile
