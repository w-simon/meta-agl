#!/bin/bash

###########################################################################
# Copyright (C) 2018 IoT.bzh
#
# Author: Romain Forlot <romain.forlot@iot.bzh>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###########################################################################


PLATFORM_HW_INFO=/etc/platform-hw-info

detect_can() {
	echo "export CAN_DEV=\"$(echo $(for x in $(ls -d /sys/class/net/*); do [ $(cat ${x}/type) -eq 128 ] && echo -n $(basename $x); echo -n ' '; done))\"" >> $PLATFORM_HW_INFO
}

detect_eth() {
	echo "export ETH_DEV=\"$(echo $(for x in $(ls -d /sys/class/net/*); do [ $(cat ${x}/type) -eq 1 ] && echo -n $(basename $x); echo -n ' '; done))\"" >> $PLATFORM_HW_INFO
}

detect_wifi() {
	echo "export WIFI_DEV=\"$(echo $(for x in $(ls -d /sys/class/net/*/wireless 2> /dev/null); do echo -n $(basename $(dirname $x)); echo -n ' '; done))\"" >> $PLATFORM_HW_INFO
}

detect_bt() {
	echo "export BT_DEV=\"$(echo $(ls -x /sys/class/bluetooth))\"" >> $PLATFORM_HW_INFO
}

detect_cpu_nb() {
	echo "export CPU_N=\"$(grep processor /proc/cpuinfo | wc -l)\"" >> $PLATFORM_HW_INFO
}

detect_mem_total() {
	echo "export MEM_TOTAL=\"$(cat /proc/meminfo | grep MemTotal | grep -Eo '[[:digit:]]* kB')\"" >> $PLATFORM_HW_INFO
}

detect_hardware() {
	detect_can
	detect_eth
	detect_wifi
	detect_bt
	detect_cpu_nb
	detect_mem_total
}

detect_renesas() {
	if [ "$(grep -i $1 /sys/devices/soc0/family)" ]
	then
		SOC_ID=$(cat /sys/devices/soc0/soc_id) 
		echo "export SOC_ID=\"${SOC_ID}\"" > $PLATFORM_HW_INFO
		echo "export FAMILY=\"$(cat /sys/devices/soc0/family)\"" >> $PLATFORM_HW_INFO
		echo "export SOC_REVISION=\"$(cat /sys/devices/soc0/revision)\"" >> $PLATFORM_HW_INFO
		echo "export BOARD_ID=\"$(echo $(tr '\0' '\n' < /sys/firmware/devicetree/base/compatible | sed -r -e '/'${SOC_ID}'/d' -e 's:.*,(.*):\1:' | tr '\n' ' '))\"" >> $PLATFORM_HW_INFO
		echo "export CPU_ARCH=\"$(grep MODALIAS /sys/devices/system/cpu/cpu0/uevent | sed -r 's:.*type\:([a-z0-9]*)\:.*$:\1:')\"" >> $PLATFORM_HW_INFO
		echo "export CPU_COMPATIBLE_0=\"$(grep OF_COMPATIBLE_0 /sys/devices/system/cpu/cpu0/uevent | cut -d',' -f2)\"" >> $PLATFORM_HW_INFO
		echo "export CPU_COMPATIBLE_1=\"$(grep OF_COMPATIBLE_1 /sys/devices/system/cpu/cpu0/uevent | cut -d',' -f2)\"" >> $PLATFORM_HW_INFO

		detect_hardware

		exit
	fi
}

for gen in Gen3
do
	detect_renesas $gen
done


