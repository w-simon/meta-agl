#comment this out to avoiud error during building weston 7.0.0 with waltham-backend
#PACKAGECONFIG[notify] = "--enable-systemd-notify,--disable-systemd-notify,systemd"
#PACKAGECONFIG_append = " notify"

RRECOMMENDS_${PN}_remove = "weston-conf"
