cd ~/tx2_workdir
sudo cp kernel/kernel-4.9/arch/arm64/boot/Image Linux_for_Tegra/kernel/Image
sudo cp kernel/kernel-4.9/arch/arm64/boot/dts/tegra186-quill-p3310-1000-c03-00-base.dtb Linux_for_Tegra/kernel/dtb/tegra186-quill-p3310-1000-c03-00-base.dtb
cd Linux_for_Tegra
sudo ./apply_binaries.sh
sudo rsync -vrltD --existing ../kernel/ ./rootfs/usr/src/linux-headers-4.9.299-tegra-ubuntu18.04_aarch64/

