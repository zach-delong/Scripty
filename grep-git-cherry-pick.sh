logOutputTmpFile="tmp.txt"
commitHashOnlyTmpFile="tmp2.txt"

# Using the other script in this repo, grab the commits we care about
grep-git-log.sh < /dev/stdin > $logOutputTmpFile

# Grab only the hashes from that output
awk -F" " '{ print $1 }' $logOutputTmpFile > $commitHashOnlyTmpFile

git-cherry-pick-hashes.sh < $commitHashOnlyTmpFile

rm $logOutputTmpFile $commitHashOnlyTmpFile
