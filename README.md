TX2 Deep Learning Kit BSP
=========================

# Needed files
- From: https://developer.nvidia.com/embedded/linux-tegra-r3273
- Download: Driver Package (BSP), Sample Root Filesystem, Driver Package (BSP) Sources, GCC 7.3.1 for 64 bit BSP and Kernel
- If links change - look here: https://developer.nvidia.com/embedded/jetpack-archive or search for "Jetpack archive nvidia"

# Recommended evironment 
- for nvidia's ./flash to work (had problems with it)
- Install Ubuntu 20.04.3 LTS (install without internet, don't update it)
- I've selected "Minimal instalation" with "third party components"

# Preparations
- Disable unattended upgrades `sudo dpkg-reconfigure unattended-upgrades`
- Select python `sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1`
- Install packages `sudo apt install picocom qemu-user-static build-essential`
- Add yourself to dialout group: `sudo usermod -aG dialout $USER`
- Reboot or execute `newgrp dialout` (only works per terminal session - like export)

# Procedure
- Place all downloaded files in your home directory (directly in ~)
- `mkdir ~/tx2_workdir && git clone https://github.com/roman-oberenkowski/tx2-deep-learning-kit-bsp ~/tx2_workdir`
- `cd ~/tx2_workdir/scripts`
- `sh unpack.sh`
- `sh build.sh` "WARNING: could not open drivers/misc/mods/mods.dtb.S: No such file or directory" is normal
- `sh prep_img.sh`
- `sh flash.sh`
- Expect `*** The target t186ref has been flashed successfully. *** Reset the board to boot from internal eMMC.`
- Board should be booting up without the need for power reset
# Flash problems
NVIDIA's flash.sh seem to have problems with new packages. Maybe it's only my impression. If flash says that "cannot detect board" or hangs on "Bootrom is not running. \n tegrarcm_v2 --isapplet" -that means that flash.sh has a problem with your system. Bootrom, bootloader, usb-connection, etc. are rather all ok. In misc there are logs from successful flash.sh and ./apply_binaries.sh runs
