sudo mount -t cifs //192.168.0.4/jdrive /mnt/jdrive -o credentials="$CRED_FILE",uid=$(id -u),gid=$(id -g)
#sudo mount -t cifs //192.168.0.4/jdrive /mnt/jdrive -o username=peterc
