# Disable meta-freescale package architecure mangling, as it causes
# issues with AGL's explicit setting of DEFAULTTUNE.
INHERIT:remove = "fsl-dynamic-packagearch"
MACHINE_SOCARCH = "${TUNE_PKGARCH}"

# Disable the meta-freescale weston-init bbappend as it conflicts
# with AGL's.
BBMASK:append = " meta-freescale/recipes-graphics/wayland/weston-init"

# do not replace or append YP core recipes at all
BBMASK:append = " meta-alb/dynamic-layers/core/"

# Avoid needing meta-python2
BBMASK:append = " meta-alb/dynamic-layers/freescale-layer/recipes-extended/vpp-core/vpp-core.bb"
BBMASK:append = " meta-alb/recipes-(connectivity|core|devtools|extended/xen|support/rng-tools)/"

# Seems like it might be worthwhile to get dunfell version, but doesn't work?:
#BBMASK:append = " meta-alb/recipes-bsp/u-boot/u-boot.inc"

PREFERRED_VERSION_rng-tools ?= "6%"

# export?
RELEASE_BASE = "release/bsp32.0"

# the label needs to be shorter than we would expand to by default !!
# Defaults to boot-${MACHINE}  which happens to be more than 11 chars
BOOTDD_VOLUME_ID = "boots32g"

AGL_DEFAULT_IMAGE_FSTYPES ?= "sdcard ext4 tar.xz"