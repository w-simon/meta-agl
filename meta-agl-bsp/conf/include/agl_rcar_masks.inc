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

# mask out meta-renesas-rcar-gen3's tweaks to base-files / and fstab
# AGL uses systemd
BBMASK += "meta-rcar-gen3/recipes-core/base-files/"

# do not modify core-image-minimal
BBMASK += "meta-rcar-gen3/recipes-core/images/core-image-minimal.bbappend"

# do not modify the nativesdk-packagegroup-sdk-host
# the comment mentions YP v2.1.2
# upstream has this included
# recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bb:    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'nativesdk-wayland', '', d)}
# and AGL as well in agl-image-graphical-qt5-crosssdk.inc
BBMASK += "meta-rcar-gen3/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend"

# do not modify the ncurse package
# the change is from 2018 and should be re-validated with dunfell and/or upstreamed
BBMASK += "meta-rcar-gen3/recipes-core/ncurses/"

# do not modify the systemd recipe
# we have our own ACLs setup for /var due to SMACK !
# meta-agl/meta-app-framework/recipes-core/base-files/base-files_%.bbappend
# meta-agl/meta-security/recipes-core/base-files/base-files_%.bbappend
BBMASK += "meta-rcar-gen3/recipes-core/systemd/"

# do not modify core-image-weston in AGL
# review it before adding
#BBMASK += "meta-rcar-gen3/recipes-graphics/images/core-image-weston.bbappend"