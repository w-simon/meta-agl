DISTRO_FEATURES_append = " sota"

OSTREE_KERNEL = "Image"
IMAGE_BOOT_FILES_sota = "renesas-ota-bootfiles/* ${DTB_SUFFIX}.dtb"
OSTREE_BOOTLOADER ?= "u-boot"

WKS_FILE = "singlepart-noloader.wks"

RENESAS_DATADIR = "/usr"

IMAGE_INSTALL_append_rcar-gen3 = " \
    kernel-devicetree \
"

# Quiet warnings about unavailable 2.4.100 version due to upstream update
PREFERRED_VERSION_libdrm_rcar-gen3 = "2.4.101"
