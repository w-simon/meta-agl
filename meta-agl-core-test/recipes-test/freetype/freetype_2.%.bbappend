FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "${SOURCEFORGE_MIRROR}/freetype/freetype-demos/${PV}/ft2demos-${PV}.tar.gz;name=ft2demos \
            file://0001-Makefile-dont-build-gfx-demos.patch;patchdir=../ft2demos-${PV} \
           "
SRC_URI[ft2demos.sha256sum] = "3089331f7b035f70eaa10c2db855a7989d9563ccc7f71142e4446031e3b5faf3"

# Enable pixmap/libpng support to allow color emojis
PACKAGECONFIG:append = " pixmap"

do_compile:append () {
    oe_runmake -C ${B} FT2DEMOS=1 TOP_DIR_2=${WORKDIR}/ft2demos-${PV}
}

do_install:append () {
    install -d -m 0755 ${D}${bindir}
    for x in ftbench ftdump ftlint ftvalid ttdebug; do
        install -m 0755 ${WORKDIR}/ft2demos-${PV}/bin/.libs/$x ${D}${bindir}
    done
}

PACKAGE_BEFORE_PN = "${PN}-demos"

FILES:${PN}-demos = "\
    ${bindir}/ftbench \
    ${bindir}/ftdump \
    ${bindir}/ftlint \
    ${bindir}/ftvalid \
    ${bindir}/ttdebug \
"
