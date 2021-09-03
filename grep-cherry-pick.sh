# Parameters! 
$branchName=$(1-origin/master) # The name of the branch we should look at when
                               # logging
$tmpFileName="tmp.txt" # The name of the temporary file to use (delete this when
                       # you are done!)

# We want to run some kind of large git log. We would like it if that log could
# preserve the order we want to cherry pick our commits in. To do that, we use
# the --grep option to search! Log will consider any commit that matches any
# grep pattern if multiple are passed in, so we should get what we want from
# essentially concatenating them all together!

stringSearchPatterns=$(awk '{ print " --grep " $0 }' /dev/stdin)

gitLogCommand="git log $branchName --oneline --first-parent $stringSearchPatterns"

# The exec command will run our code in a string, and we use awk to grab only
# the commit hash from the output.
exec $gitLogCommand | awk -F" " '{ print $1 }' > tmp.txt

# tac will iterate over the file (line by line) in reverse. The temp file is
# currently one commit hash per line with the oldest at the bottom, so we should
# cherry pick in the reverse order!
tac tmp.txt | xargs git cherry-pick -m1

# now that we're done, lets clean up
rm $tmpFileName
