SUMMARY = "An AGL small image just capable of allowing a device to boot with audio management."

require agl-image-minimal.inc

LICENSE = "MIT"

IMAGE_INSTALL_append = "\
    packagegroup-agl-image-minimal \
    packagegroup-agl-core-sound \
    "
