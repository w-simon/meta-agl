inherit systemd

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://ti-uim.service"

SYSTEMD_SERVICE:${PN} = "ti-uim.service"

PR = "r0"
PV = "0.1+git${SRCPV}"

do_install:append() {
    # We do not want the blacklist
    rm -f ${D}/${sysconfdir}/modprobe.d/ti_bt.conf

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/ti-uim.service ${D}${systemd_unitdir}/system
}
