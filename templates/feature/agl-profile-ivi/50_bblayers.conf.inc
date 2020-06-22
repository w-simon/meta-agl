BBLAYERS =+ " \
  ${METADIR}/meta-agl/meta-agl-profile-graphical \
"

AGL_APPFW_LAYERS = " \
  ${METADIR}/external/meta-security \
  ${METADIR}/external/meta-openembedded/meta-perl \
  ${METADIR}/meta-agl/meta-security \
  ${METADIR}/meta-agl/meta-app-framework \
    "


# These are the direct dependencies of the AGL CORE Layers
#---------------------------------------------------------
AGL_IVI_DEPENDENCY_LAYERS = " \
  ${METADIR}/external/meta-openembedded/meta-oe \
  ${METADIR}/external/meta-openembedded/meta-multimedia \
  ${METADIR}/external/meta-openembedded/meta-networking \
  ${METADIR}/external/meta-openembedded/meta-python \
  ${METADIR}/external/meta-openembedded/meta-filesystems \
  "

####################
# Combine the layers
BBLAYERS =+ " \
  ${AGL_IVI_DEPENDENCY_LAYERS} \
  ${AGL_APPFW_LAYERS} \
  "
