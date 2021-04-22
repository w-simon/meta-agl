DESCRIPTION = "AGL container config host"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD;md5=3775480a712fc46a69647678acb234cb"

PR = "r0"

S = "${WORKDIR}"

SRC_URI = " \
    file://cluster-guest \
    file://dummy-guest \
    file://cluster-guest-environment \
    file://dummy-guest-environment \
"

inherit systemd

do_install () {
    # setup container dir 
    install -m 0755 -d ${D}/opt/guests/cluster-guest
    install -m 0755 -d ${D}/opt/guests/dummy-guest

    # install lxc configs
    install -m 0755 -d ${D}/var/lib/lxc/cluster-guest
    install -m 0644 ${WORKDIR}/cluster-guest ${D}/var/lib/lxc/cluster-guest/config
    install -m 0644 ${WORKDIR}/cluster-guest-environment ${D}/var/lib/lxc/cluster-guest/environment

    install -m 0755 -d ${D}/var/lib/lxc/dummy-guest
    install -m 0644 ${WORKDIR}/dummy-guest ${D}/var/lib/lxc/dummy-guest/config
    install -m 0644 ${WORKDIR}/dummy-guest-environment ${D}/var/lib/lxc/dummy-guest/environment
}

PACKAGES = "\
    ${PN} \
"

FILES_${PN} = " \
    /opt/guests/*      \
    /var/lib/lxc/*     \
    /var/lib/lxc/*/*   \
"
