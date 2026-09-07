CRED_FILE="$HOME/.smbcreds/blk.cred"
sudo mount -t cifs "//192.168.0.6/Kpass" "/mnt/kpass" -o credentials="$CRED_FILE",uid=$(id -u),gid=$(id -g)
