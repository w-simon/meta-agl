SUMMARY = "HTTP REST interface to automotive backends for HTML5 UI support"
DESCRIPTION = "Automotive-Framework-Binder Daemon provides a HTTP REST \
interface to various automotive-oriented bindings, \
allowing HTML5 UIs to send platform-specific requests in a secure way."

HOMEPAGE = "https://gerrit.automotivelinux.org/gerrit/#/admin/projects/src/app-framework-binder"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE-2.0.txt;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI = "git://gerrit.automotivelinux.org/gerrit/src/app-framework-binder;protocol=https;branch=${AGL_BRANCH}"

SRCREV = "99ad30bf29c683da833efeac42d8f178b6d2ca8c"
PV = "${AGL_BRANCH}+git${SRCPV}"

S = "${WORKDIR}/git"

CFLAGS_append_agl-devel = " -DAGL_DEVEL"

EXTRA_OECMAKE_append = "\
	-DAGLVERSION=${AGLVERSION} \
"

