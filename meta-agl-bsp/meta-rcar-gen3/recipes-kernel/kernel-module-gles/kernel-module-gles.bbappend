require checksum_control.inc

module_do_compile_prepend() {
    cd ${S}/build/linux/config/compilers
    cp aarch64-linux-gnu.mk ${TARGET_SYS}.mk
}
