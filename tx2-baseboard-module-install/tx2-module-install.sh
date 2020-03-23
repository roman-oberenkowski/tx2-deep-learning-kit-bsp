#!/bin/bash

RES_DIR="$(pwd)/resources"

# u-boot related settings
INST_STATUS=0

# check for root
if [[ $EUID -ne 0 ]];
then
    echo "Root privilages are required. Try:"
    echo "sudo $0"
    exit 1
fi

# update modules
echo "Updating kernel modules..."
if [ -d "/lib/modules/4.9.140-tegra" ]; then
    rm -r "/lib/modules/4.9.140-tegra"
fi
if ! cp -r "$RES_DIR/modules-4.9.140-tegra" "/lib/modules/4.9.140-tegra"
then
    INST_STATUS=1
    echo "Unable to update kernel modules."
fi

# update password
echo "root:root" | chpasswd
# allow root login
sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config


# set hostname
echo "antmicro-tx2-baseboard" > /etc/hostname
echo -n -e "127.0.0.1 localhost\n127.0.0.1 antmicro-tx2-baseboard\n" > /etc/hosts

# update linux-headers
echo "Updating linux-headers..."
if ! cp -r "$RES_DIR/linux-headers-4.9.140-tegra" "/usr/src/"
then
    INST_STATUS=1
    echo "Unable to copy linux-headers-4.9.140-tegra"
fi

sync

if [[ $INST_STATUS -eq 0 ]]; then
    echo "Installation finished. You can now reboot the board."
else
    echo "Installation failed."
# revert changes
fi
