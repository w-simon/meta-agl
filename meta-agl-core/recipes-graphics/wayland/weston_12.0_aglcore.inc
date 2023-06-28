FILESEXTRAPATHS:append := ":${THISDIR}/weston"

PACKAGECONFIG:append = "${@bb.utils.contains('DISTRO_FEATURES', 'weston-remoting', ' remoting', '', d)}"

SRC_URI += "file://0001-libweston-weston-log-Add-an-iterator-for-going-over-.patch"
