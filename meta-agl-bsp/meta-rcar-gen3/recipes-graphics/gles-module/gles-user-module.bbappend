require checksum_control.inc

do_install:append(){
	 sed -i 's/GROUP="video"/GROUP="display"/g' ${D}${sysconfdir}/udev/rules.d/72-pvr-seat.rules 
}
