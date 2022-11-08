FILESEXTRAPATHS:append := ":${THISDIR}/weston"

PACKAGECONFIG:append = "${@bb.utils.contains('DISTRO_FEATURES', 'weston-remoting', ' remoting', '', d)}"

SRC_URI:append = "file://0001-libweston-Send-name-description-update-wl_output-to-.patch \
		  file://0001-simple-touch-Add-maximized-fullscreen-states.patch \
		  file://0001-libweston-weston-log-Add-an-iterator-for-going-over-.patch "
