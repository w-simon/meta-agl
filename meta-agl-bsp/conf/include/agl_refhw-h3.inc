AGL_FEATURES_append = " agl-refhw-h3"

# Reference hardware has USB3
MACHINE_FEATURES_append = " usb3"

KERNEL_DEVICETREE_append = " renesas/r8a77951-agl-refhw.dtb"

UBOOT_CONFIG_append = " agl-refhw"
UBOOT_CONFIG[agl-refhw] = "rcar3_salvator-x_defconfig"

MACHINE_EXTRA_RRECOMMENDS_append_h3ulcb = " \
    linux-firmware-wl18xx \
    ti-bt-firmware \
    wlconf \
    wireless-regdb-static \
"
