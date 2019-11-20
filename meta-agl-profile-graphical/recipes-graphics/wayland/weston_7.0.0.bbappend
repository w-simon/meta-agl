FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = "\
    file://use-XDG_RUNTIMESHARE_DIR.patch \
    file://0001-Allow-regular-users-to-launch-Weston_7.0.0.patch \
    "

EXTRA_OEMESON_append += "-Dsys-uid=true"
