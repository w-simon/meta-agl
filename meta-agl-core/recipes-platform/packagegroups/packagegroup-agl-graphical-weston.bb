DESCRIPTION = "The minimal set of packages required for the Weston compositor"
LICENSE = "MIT"

inherit packagegroup features_check

# weston-init requires pam enabled if started via systemd
REQUIRED_DISTRO_FEATURES = "wayland ${@oe.utils.conditional('VIRTUAL-RUNTIME_init_manager', 'systemd', 'pam', '', d)}"

RDEPENDS:${PN} += " \
    weston \
    weston-init \
    ${@bb.utils.filter('DISTRO_FEATURES', 'polkit', d)} \
"
