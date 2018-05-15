SUMMARY = "A very basic Wayland image with a terminal"

require agl-image-graphical-qt5-crosssdk.inc

LICENSE = "MIT"

IMAGE_INSTALL_append = "\
    packagegroup-agl-image-weston \
    "

