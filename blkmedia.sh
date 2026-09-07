CRED_FILE="$HOME/.smbcreds/blk.cred"
sudo mount -t cifs "//192.168.0.6/Multimedia" "/mnt/blkmedia" -o credentials="$CRED_FILE",uid=$(id -u),gid=$(id -g)
