# export env vars
cd ~/tx2_workdir
export ARCH=arm64
export PATH=${PWD}/toolchain/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin/:$PATH
export CROSS_COMPILE=aarch64-linux-gnu-

# build kernel
cd ~/tx2_workdir/kernel/kernel-4.9
make tegra_defconfig LOCALVERSION="-tegra"
make -j12 LOCALVERSION="-tegra"
make -j12 modules LOCALVERSION="-tegra"
cp .config kernel_config
