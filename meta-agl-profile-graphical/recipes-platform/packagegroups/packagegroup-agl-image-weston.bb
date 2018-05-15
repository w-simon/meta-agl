DESCRIPTION = "The minimal set of packages required for basic Wayland image"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-agl-image-weston \
    profile-agl-graphical \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += " \
                  weston \
                  weston-init \
                  weston-ini-conf \
                  weston-examples \
                  agl-login-manager \
                  packagegroup-agl-image-minimal \
                  "

RDEPENDS_profile-agl-graphical = "${PN}"
