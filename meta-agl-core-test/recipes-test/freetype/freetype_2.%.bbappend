FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "${SOURCEFORGE_MIRROR}/freetype/freetype-demos/${PV}/ft2demos-${PV}.tar.gz;name=ft2demos \
            file://0001-Makefile-dont-build-gfx-demos.patch;patchdir=../ft2demos-${PV} \
            file://0001-ft2demos-Makefile-Do-not-hardcode-libtool-path.patch;patchdir=../ft2demos-${PV} \
           "
SRC_URI[ft2demos.sha256sum] = "f1e61ab2bc5f2348f0318ed18adba3aff344b60a519192417811ebfbf7253228"

# Enable pixmap/libpng support to allow color emojis
PACKAGECONFIG_append = " pixmap"

do_compile_append () {
    oe_runmake -C ${B} FT2DEMOS=1 TOP_DIR_2=${WORKDIR}/ft2demos-${PV}
}

do_install_append () {
    install -d -m 0755 ${D}${bindir}
    for x in ftbench ftdump ftlint ftvalid ttdebug; do
        install -m 0755 ${WORKDIR}/ft2demos-${PV}/bin/.libs/$x ${D}${bindir}
    done
}

PACKAGE_BEFORE_PN = "${PN}-demos"

FILES_${PN}-demos = "\
    ${bindir}/ftbench \
    ${bindir}/ftdump \
    ${bindir}/ftlint \
    ${bindir}/ftvalid \
    ${bindir}/ttdebug \
"

