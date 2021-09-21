require checksum_control.inc

RDEPENDS_${PN}_append = " wayland-wsegl"

do_install_append(){
	 sed -i 's/MODE="0660", OWNER/MODE="0660", SECLABEL{smack}="*", OWNER/g' ${D}${sysconfdir}/udev/rules.d/72-pvr-seat.rules 
	 sed -i 's/GROUP="video"/GROUP="display"/g' ${D}${sysconfdir}/udev/rules.d/72-pvr-seat.rules 
}
