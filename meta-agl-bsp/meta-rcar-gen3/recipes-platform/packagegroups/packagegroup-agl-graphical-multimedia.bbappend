RDEPENDS:${PN}:append:rcar-gen3 = "\
    ${@bb.utils.contains('MACHINE_FEATURES','multimedia','packagegroup-multimedia-kernel-modules','',d)} \
    ${@bb.utils.contains('MACHINE_FEATURES','multimedia','packagegroup-multimedia-libs','',d)} \
    ${@bb.utils.contains('MACHINE_FEATURES','multimedia','packagegroup-gstreamer1.0-plugins','',d)} \
    "
