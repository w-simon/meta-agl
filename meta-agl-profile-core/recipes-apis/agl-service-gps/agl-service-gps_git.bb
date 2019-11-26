SUMMARY     = "GPS/GNSS Service Binding"
DESCRIPTION = "AGL GPS/GNSS Service Binding"
HOMEPAGE    = "https://gerrit.automotivelinux.org/gerrit/#/admin/projects/apps/agl-service-gps"
SECTION     = "apps"

LICENSE     = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=ae6497158920d9524cf208c09cc4c984"

SRC_URI = "git://gerrit.automotivelinux.org/gerrit/apps/agl-service-gps;protocol=https;branch=${AGL_BRANCH}"
SRCREV  = "${AGL_APP_REVISION}"

# This will be removed after mergning https://gerrit.automotivelinux.org/gerrit/c/apps/agl-service-gps/+/23052 
SRC_URI += "file://0001-Change-read-api-in-gpsd-3.19.patch"

PV = "1.0+git${SRCPV}"
S  = "${WORKDIR}/git"

DEPENDS = "json-c gpsd"
RDEPENDS_${PN} = "libgps"

inherit cmake aglwgt pkgconfig
