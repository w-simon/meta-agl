FILESEXTRAPATHS:prepend := "${THISDIR}/qtlocation:"

SRC_URI += "\
    file://0001-mapbox-update-API-url-to-match-new-schema.patch \
    file://0001-mapbox-gl-explicitly-include-cstdint-header.patch;patchdir=src/3rdparty/mapbox-gl-native \
    "

# Need to explicitly enable the various plugins
PACKAGECONFIG += " \
	geoservices_osm \
	geoservices_here \
	geoservices_itemsoverlay \
	geoservices_mapbox \
	geoservices_mapboxgl \
"
