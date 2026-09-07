CRED_FILE="$HOME/.smbcreds/jdrive.cred"
sudo mount -t cifs "//192.168.0.4/jdrive" "/mnt/jdrive" -o credentials="$CRED_FILE",uid=$(id -u),gid=$(id -g)
