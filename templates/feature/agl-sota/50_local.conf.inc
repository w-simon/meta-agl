#see meta-updater/conf/distro/sota.conf.inc
INHERIT += "sota"
DISTRO_FEATURES_append = " sota usrmerge"
DISTRO_FEATURES_NATIVE_append = " sota"
AGL_DEFAULT_INITRAMFS_FSTYPES = "cpio.gz"
# rpi4 and recent rpi3 firmwares need dtb in /boot partition
# so that they can be read by the firmware. This fixes UART
# issues for Raspberry Pi 3. For branches based on release
# Thud this fix is not present in meta-updater.
IMAGE_BOOT_FILES_append_rpi = "${@make_dtb_boot_files(d)}"
