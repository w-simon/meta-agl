SUMMARY     = "A wrapper library of libhomescreen for Qt Application in AGL"
SECTION     = "libs"
LICENSE     = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=2ee41112a44fe7014dce33e26468ba93"

DEPENDS = "qtbase libhomescreen qtdeclarative"
RDEPENDS_${PN} = "libhomescreen"

inherit qmake5

SRC_URI = "git://gerrit.automotivelinux.org/gerrit/src/libqthomescreen.git;protocol=https;branch=sandbox/zheng_wenlong/als2019_vertical"
SRCREV = "${AUTOREV}"
S = "${WORKDIR}/git"
