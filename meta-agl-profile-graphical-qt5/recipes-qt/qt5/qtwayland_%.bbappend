FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

# QT_MODULE_BRANCH = "5.4"

# TODO:
#  These patches for IVI-SHELL are tempolary disabled because of issues. And new
#  patches are proposed.
#
#    file://0020-Add-IVI-Shell-protocol-file-version-patch-v6.patch \
#    file://0021-Implement-initial-IVI-Shell-support.patch \
#    file://0001-protocol-update-3rd-party-ivi-application-protocol.patch \
#    file://0002-qwaylandwindow-add-support-for-IVI-Surface-ID-proper.patch \
#
#  The xdg-shell merged into upstream, so we don't need these patch anymore.
#  But xdg-shell doesn't work well in current AGL Distro because of
#  mismatch of protocol versions between server(weston) and client(Qt Apps).
#
#    file://0016-xdg-shell-Add-xdg-shell-protocol-file-version-1.4.0.patch \
#    file://0017-xdg-shell-Add-minimize-feature-to-QWindow-using-wayl.patch \
#    file://0019-xdg-shell-upgrade-to-support-current-version-weston-.patch \
#

SRC_URI_append = "\
    file://0010-Added-manifest-file-according-to-smack-3-domain-mode.patch \
    "

AGL_DEFAULT_WM_SHELL ?= "xdg-shell"
AFM_CONF_DIR = "${D}${sysconfdir}/afm/unit.env.d"
QT_SHELL_FILE = "${AFM_CONF_DIR}/qt-shell"

do_install_append_class-target() {
	mkdir -p ${AFM_CONF_DIR}
	echo "QT_WAYLAND_SHELL_INTEGRATION=${AGL_DEFAULT_WM_SHELL}" > ${QT_SHELL_FILE}
	echo -ne "# The following might be necessary to be enabled when multiple/split surfaces\n"\
		"# are created. Without this enabled, QtWayland will sometimes maintain the same/old\n"\
		"# size even if the split surface is destroyed. We keep it disabled by default as it\n"\
		"# causes an additional repaint of the surface until the compositor sends a configure\n"\
		"# event to scale the window to the actual area. Typical windows will default to a initial\n"\
		"# size when starting-up without an explicit size specified. Note that QtWayland will only test\n"\
	        "# the presence of the environment variable so it will be enabled even if set to 0\n" >> ${QT_SHELL_FILE}
	echo "#QT_WAYLAND_RESIZE_AFTER_SWAP=1" >> ${QT_SHELL_FILE}
}
