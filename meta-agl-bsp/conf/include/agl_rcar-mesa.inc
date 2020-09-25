require conf/include/agl_rcar-nogfx.inc

# for Wayland/Weston
PREFERRED_PROVIDER_virtual/libgles1 = "mesa"
PREFERRED_PROVIDER_virtual/libgles2 = "mesa"
PREFERRED_PROVIDER_virtual/egl = "mesa"
PREFERRED_PROVIDER_virtual/libgl = "mesa"
PREFERRED_PROVIDER_virtual/mesa = "mesa"
PREFERRED_PROVIDER_libgbm = "mesa"
PREFERRED_RPROVIDER_libgbm-dev = "mesa"

#GALLIUMDRIVERS_append = ""
# Mask out meta-renesas-rcar-gen3's tweaks to weston-init, as they do
# not seem necessary for anything in AGL, and the addition of
# dbus.service and multi-user.target dependencies to the weston systemd
# unit that is done is problematic with respect to potentially blocking
# weston if any user units like application framework "platform"
# services fail. They also likely affect boot up speed with respect to
# getting weston started.  There is no clear rationale expressed in the
# meta-renesas-rcar-gen3 commit history for the extra dependencies, and
# testing shows no issues on H3ULCB when not having them.
BBMASK += "meta-rcar-gen3/recipes-graphics/wayland/weston-init.bbappend"

IMAGE_INSTALL_append_rcar-gen3 = " \
    kernel-devicetree \
"
