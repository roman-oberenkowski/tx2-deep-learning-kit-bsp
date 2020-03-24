TX2 Deep Learning Kit BSP
=========================
<img src="https://github.com/EmbeddedPaul166/tx2-deep-learning-kit-bsp/blob/master/Images/tx2-deep-learning-kit.png">
 
This is a fork of original BSP from antmicro, that contains a port for linux kernel 4.9 (Jetpack 4.3). Current release offers OV5640 cameras support, but has disabled USB 3.0 port, which will probably be fixed in the near future.

# Deployment

Steps for deployment are similar to original in https://github.com/antmicro/tx2-deep-learning-kit-bsp with minor changes:
- download compiler, driver package and sample rootfs from this site https://developer.nvidia.com/embedded/linux-tegra (L4T r32.3.1)
- change file paths accordingly to above changes
- change LOCALVERSION from "-antmicro" to "-tegra" in all appropriate commands

Tip: When testing cameras add "sync=0" at the end of the pipeline. Without this option framerate drops substantially in all power modes except power mode 1 (power mode switching can be done using nvpmodel utility).
