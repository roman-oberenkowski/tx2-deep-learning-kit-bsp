TX2 Deep Learning Kit BSP
=========================
# Version
- Kernel: 4.9.299
- Jetpack: 4.6.3
- Linux for Tegra: r32.7.3

# Needed files
From: https://developer.nvidia.com/embedded/linux-tegra-r3273 Download: 
- Driver Package (BSP) - Jetson_Linux_R32.7.3_aarch64.tbz2
- Sample Root Filesystem - Tegra_Linux_Sample-Root-Filesystem_R32.7.3_aarch64.tbz2
- GCC 7.3.1 for 64 bit BSP and Kernel - gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz
- If links change - look here: https://developer.nvidia.com/embedded/jetpack-archive or search for "Jetpack archive nvidia"

# Recommended evironment 
For nvidia's ./flash to work (had many problems with it)
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
- `sh build.sh`, message: "WARNING: could not open drivers/misc/mods/mods.dtb.S: No such file or directory" is normal
- `sh prep_img.sh`, Note: It will update headers (but not modules) with generated ones 
- (optional) Create user to skip OEM config later: `sudo ~/tx2_workdir/Linux_for_Tegra/tools/l4t_create_default_user.sh -u user -p password`
- `sh flash.sh`
- Expect `*** The target t186ref has been flashed successfully. *** Reset the board to boot from internal eMMC.`
- Board should boot up without the need for power reset

# Flash.sh problems
NVIDIA's flash.sh seem to have problems with new packages (at least it had for me). If flash says that "cannot detect board" or hangs on "Bootrom is not running. tegrarcm_v2 --isapplet" - that means that flash.sh has a problem with your system. Bootrom, bootloader, usb-connection, etc. are rather all ok. To help debug diffrent problems - in the misc folder there are logs from successful flash.sh and apply_binaries.sh runs.

# Serial terminal
`picocom -b 115200 /dev/ttyUSB0` 
- To find correct ttyUSBx number - use ls /dev/ttyUSB* before and after connecting the cable
- Serial console will only be available after Ubuntu setup (needs keyboard/mouse)

# Camera test
When testing cameras add "sync=0" at the end of the pipeline. Without this option framerate drops substantially in all power modes except power mode 1 (power mode switching can be done using nvpmodel utility).
- `DISPLAY=:0 gst-launch-1.0 -vvv v4l2src device=/dev/video4 ! 'video/x-raw,format=UYVY,width=1920,height=1080,framerate=30/1' ! nvvidconv ! 'video/x-raw(memory:NVMM), format=I420' ! nvoverlaysink sync=0`

