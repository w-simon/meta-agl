# Prevent configuration error in xmlsec1-native build
PACKAGECONFIG_remove = "nss"

BBCLASSEXTEND = "native nativesdk"
