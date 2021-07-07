#! /bin/zsh

# This script is just designed to pull the currently logged in user's first name
# from the /etc/passwd file. On popOS, this is in the 5th cell of the file, inside
# the "historical" data.

cat /etc/passwd | # Read the file
    grep $USER | # Look for the currently authenticated user in the file
    awk -F ':' '{print $5}' | # Examine only the 5th cell (should be of the form First Last, ..., with a bunch of stuff I don't care about)
    awk -F ',' '{print $1}' | # Split the comma delimited list grabbing only the full name
    awk -F ' ' '{print $1}' # Split the full name just grabbing the first name
