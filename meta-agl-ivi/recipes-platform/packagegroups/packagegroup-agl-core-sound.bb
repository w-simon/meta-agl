SUMMARY = "The packages of middlewares for AGL IVI profile"
DESCRIPTION = "The set of packages required by Sound Management Subsystem"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
    packagegroup-agl-core-sound \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
    pipewire \
    "
