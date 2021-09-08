# Parameters!
branchName=${1-origin/master} # The name of the branch we should look at when
                              # logging

# We want to run some kind of large git log. We would like it if that log could
# preserve the order we want to cherry pick our commits in. To do that, we use
# the --grep option to search! Log will consider any commit that matches any
# grep pattern if multiple are passed in, so we should get what we want from
# essentially concatenating them all together!

stringSearchPatterns=$(awk '{ print " --grep " $0 }' /dev/stdin)

gitLogCommand="git log $branchName --oneline --first-parent $stringSearchPatterns"

# The exec command will run our code in a string, and we use awk to grab only
# the commit hash from the output.
exec $gitLogCommand | tac
