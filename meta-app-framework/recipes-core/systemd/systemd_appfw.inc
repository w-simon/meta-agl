# Ensures systemd runs with label "System"
EXTRA_OEMESON_append_with-lsm-smack = " -Dsmack-run-label=System"

##################################################################################
# What follows is temporary.
# This is a solution to the Bug-AGL SPEC-539
# (see https://jira.automotivelinux.org/browse/SPEC-539).
#
# It renames the file "touchscreen.rules" to "55-touchscreen.rules"
# This comes with the recipe systemd_230/234 of poky (meta/recipes-core/systemd)
# It should be removed when poky changes.
##################################################################################
do_install_prepend() {
	mv ${WORKDIR}/touchscreen.rules ${WORKDIR}/55-touchscreen.rules || true
}

