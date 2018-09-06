SUMMARY     = "IIODEVICES Service Binding"
DESCRIPTION = "AGL IIODEVICES Service Binding"
HOMEPAGE    = "https://gerrit.automotivelinux.org/gerrit/#/admin/projects/apps/afb-helpers"
SECTION     = "apps"

LICENSE     = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

#SRC_URI = "gitsm://gerrit.automotivelinux.org/gerrit/apps/app-controller-submodule;protocol=https;branch=${AGL_BRANCH}"
#SRCREV  = "${AGL_APP_REVISION}"
SRC_URI = "gitsm://gerrit.automotivelinux.org/gerrit/apps/app-controller-submodule;protocol=https;branch=sandbox/benierc/shared-library"
SRCREV  = "${AUTOREV}"

S  = "${WORKDIR}/git"

DEPENDS += "af-binder lua afb-helpers"
RDEPENDS_${PN} += "afb-helpers"

inherit cmake pkgconfig

FILES_${PN} = "${libdir}/*"
FILES_${PN}-dev = "${includedir}/*"
