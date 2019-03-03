require recipes-kernel/linux/linux-agl.inc
require recipes-kernel/linux/linux-agl-4.9.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://cma-256.cfg"
