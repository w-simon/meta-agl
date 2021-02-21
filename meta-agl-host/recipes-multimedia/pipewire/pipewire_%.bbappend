PACKAGECONFIG = "\
    ${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)} \
    alsa \
    pipewire-alsa \
"
#TODO: audioconvert audiomixer
