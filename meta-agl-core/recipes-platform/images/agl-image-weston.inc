require recipes-platform/images/agl-image-minimal.inc

# NOTE: In hardknott or later this can be replaced by adding "weston"
#       to IMAGE_FEATURES.
SYSTEMD_DEFAULT_TARGET = "graphical.target"

inherit features_check

REQUIRED_DISTRO_FEATURES = "wayland"
