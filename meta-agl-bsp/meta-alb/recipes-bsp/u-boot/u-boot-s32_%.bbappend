# Missing from the meta-alb u-boot.inc
inherit python3native

DEPENDS:remove = "python-native"
DEPENDS:append = " python3-native"
