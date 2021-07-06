cat /etc/passwd | grep $USER | awk -F ':' '{print $5}' | awk -F ',' '{print $1}' | awk -F ' ' '{print $1}'
