# While there is input to pick, log that we picked it and attempt to grab!
while read hash;
do
    echo "Attempting to pick $hash"
    git cherry-pick -m1 $hash

done < /dev/stdin
