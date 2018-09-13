SUMMARY = "Basic hardware tests for different platform"
DESCRIPTION = "Test hardware of different platforms."
#HOMEPAGE = "https://gerrit.automotivelinux.org/gerrit/#/admin/projects/apps/app-afb-test"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "file://${PN}.tar.gz \
	   file://run-ptest \
"

SRC_URI[md5sum]="5717b7fcaf8b6654238853768cbfc267"

RDEPENDS_${PN}  += "bash"
RDEPENDS_${PN}-ptest += "bash make"

PV = "${AGLVERSION}"

S = "${WORKDIR}/${PN}"

inherit ptest

FILES_${PN} = "${sysconfdir}/agl-postinsts/detect-board.sh \
               ${bindir}/detect-board.sh \
"

do_compile() {
}

do_install() {
	install -D ${S}/detect-board.sh ${D}${sysconfdir}/agl-postinsts/detect-board.sh
	install -D ${S}/detect-board.sh ${D}${bindir}/detect-board.sh
}

do_install_ptest() {
	install -d ${D}${PTEST_PATH}/tests
	install -D ${S}/Makefile* ${D}${PTEST_PATH}
	install -D ${S}/tests/* ${D}${PTEST_PATH}/tests
}

