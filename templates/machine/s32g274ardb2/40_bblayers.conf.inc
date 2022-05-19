# This must be parsed after qt5, etc. layers so that they are correctly
# recognized by meta-freescale/dynamic-layers
BBLAYERS =+ "\
  ${METADIR}/bsp/meta-freescale \
  ${METADIR}/bsp/meta-alb \
  ${METADIR}/bsp/meta-linaro/meta-optee \
  ${METADIR}/external/meta-python2 \
  "
