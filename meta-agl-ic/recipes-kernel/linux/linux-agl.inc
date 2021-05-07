FILESEXTRAPATHS_prepend := "${THISDIR}/linux:"

DEPENDS += "kern-tools-native"

# returns all the elements from the src uri that are .cfg files
def find_cfgs(d):
    sources=src_patches(d, True)
    sources_list=[]
    for s in sources:
        if s.endswith('.cfg'):
            sources_list.append(s)

    return sources_list

do_configure_append () {
    [ ! -f .config ] && cp -a ${WORKDIR}/defconfig .config
    # Need to clear CONFIG_LSM for 5.1+ kernels to ensure it'll get
    # regenerated to reflect configuration changes (e.g. SMACK).
    sed -i '/^CONFIG_LSM/d' .config
    merge_config.sh -m .config ${@" ".join(find_cfgs(d))}
    yes '' | make oldconfig
}

# Extra configuration options for the AGL kernel
SRC_URI_append = "\
        "
KERNEL_CONFIG_FRAGMENTS_append = " ${WORKDIR}/*.cfg"
