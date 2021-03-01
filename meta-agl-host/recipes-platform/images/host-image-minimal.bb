SUMMARY = "A small image just capable of allowing a device to boot."

IMAGE_INSTALL = " \
        packagegroup-agl-host-boot \
        ${CORE_IMAGE_EXTRA_INSTALL} \
        packagegroup-agl-host-container-runtime \
        packagegroup-agl-host-sound \
        container-host-config \
        kernel-devicetree \
        pipewire-alsa alsa-utils nano \
      "

IMAGE_LINGUAS = " "

LICENSE = "MIT"

inherit core-image

IMAGE_ROOTFS_SIZE ?= "8192"
IMAGE_ROOTFS_EXTRA_SPACE_append = "${@bb.utils.contains("DISTRO_FEATURES", "systemd", " + 4096", "" ,d)}"
