FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

require recipes-kernel/linux/linux-agl.inc

# Add ADSP patch to enable and add sound hardware abstraction
SRC_URI_append = " \
    file://0004-ADSP-enable-and-add-sound-hardware-abstraction.patch \
"
