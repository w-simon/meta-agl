FILESEXTRAPATHS_prepend := "${THISDIR}/dbus-cynara:"

SRC_URI_append_class-target = "\
   file://0001-Integration-of-Cynara-asynchronous-security-checks.patch \
   file://0005-Perform-Cynara-runtime-policy-checks-by-default.patch \
"

DEPENDS_append_class-target = " cynara smack"
EXTRA_OECONF_append_class-target = " ${@bb.utils.contains('DISTRO_FEATURES','smack','--enable-cynara --disable-selinux','',d)}"

