# E3 emulation with M3 (AGL cluster profile)

## Adding the feature into an AGL build

In your AGL-yocto folder, enter the commands below:

```bash
repo init -b sandbox/pmarzin/e3-emulation -u https://gerrit.automotivelinux.org/gerrit/AGL/AGL-repo -m e3-emulation.xml
repo sync -j8 -q

source meta-agl/scripts/aglsetup.sh -m m3ulcb agl-devel agl-demo agl-appfw-smack iotbzh-custom
bitbake agl-demo-platform
```

When finished, flash the new BSP and boot the board as usual.

**INFO:** all e3-emulation work is located into `meta-agl/meta-agl-bsp/meta-rcar-gen3/recipes-bsp/emulation/`

## How the feature works

A systemd service (named "platform-e3-emulation.service") is installed and always started at boot. This systemd service launches this script command : `/usr/libexec/platform-e3-emulation/e3-emulation start`.

This script will check either the emulation feature is enabled or not. To do that, the script will check if the feature `agl.renesas.emul_e3=yes` is specified within the kernel command line (here : `/proc/cmdline`). If set to yes, then the script will start to downgrade the M3ULCB performance to reach the E3 ones.

To summarize, there are two mechanisms to enable the E3 emulation :
  1. Kernel command line feature (not added by default) : `agl.renesas.emul_e3=yes`
  2. systemd service (enabled by default) to control the script : `platform-e3-emulation.service`

## What the feature do

The script (e3-emulation) will detect the used board (actually only support M3ULCB boards) and apply some tricks to downgrade CPU frequencies, disable some CPU cores and reduce GPU frequency.

## Enable and verify the feature

To enable the feature, just add `agl.renesas.emul_e3=yes` to the kernel command line. And when booted, it can be controlled through the systemd service.

Verify that the script did start well and if the CPU has been successfully downgraded :

```
m3ulcb:~# systemctl status platform-e3-emulation.service
● platform-e3-emulation.service - platform-e3-emulation
   Loaded: loaded (/lib/systemd/system/platform-e3-emulation.service; enabled; vendor preset: enabled)
   Active: active (exited) since Thu 2020-02-20 13:08:33 UTC; 2 weeks 4 days ago
  Process: 3149 ExecStart=/usr/libexec/platform-e3-emulation/e3-emulation start (code=exited, status=0/SUCCESS)
 Main PID: 3149 (code=exited, status=0/SUCCESS)

Feb 20 13:08:32 m3ulcb e3-emulation[3149]: Starting E3 emulation...
Feb 20 13:08:33 m3ulcb e3-emulation[3149]: Summary :
Feb 20 13:08:33 m3ulcb e3-emulation[3149]:  cpu0 : 1000 MHz
Feb 20 13:08:33 m3ulcb e3-emulation[3149]:  cpu1 : Disabled
Feb 20 13:08:33 m3ulcb e3-emulation[3149]:  cpu2 : 1200 MHz
Feb 20 13:08:33 m3ulcb e3-emulation[3149]:  cpu3 : Disabled
Feb 20 13:08:33 m3ulcb e3-emulation[3149]:  cpu4 : Disabled
Feb 20 13:08:33 m3ulcb e3-emulation[3149]:  cpu5 : Disabled
Feb 20 13:08:33 m3ulcb e3-emulation[3149]:  gpu  : 200 MHz
Warning: Journal has been rotated since unit was started. Log output is incomplete or unavailable.
```

## Reducing DDR Frequency of M3/H3

All tricks could not be done only with software.
Indeed, in order to downgrade DDR performance, it is possible to reduce DDR frequency using SW6 on M3ULCB or H3ULCB. By disabling pin 1 and 2 of SW6, DDR frequency will be set to 1600 MHz instead of 3200 MHz.  

This tab is resuming the switch positions of SW6.

| SW6          | #1  | #2  | #3 | #4 |
|:------------:|:---:|:---:|:--:|:--:|
| DDR 3200 MHz | ON  | ON  | ON | ON |
| DDR 1600 MHz | OFF | OFF | ON | ON |

Please be careful when manipulating these small switches. And do it **ONLY when the board is powered OFF**!

## Expected results - using agl-benchmark

The iotbzh-custom feature add some benchmark tools and a script named [agl-benchmark](https://github.com/iotbzh/meta-iot-bzh/blob/sandbox/pmarzin/e3-emulation/meta-custom/recipes-benchmark/platform-benchmark/files/agl-benchmark). This script will get HW info and will run some tests to analyze the board performance. The benchmarks are always the same for a board to an other and the script will print a result at the end of the tests.

To run the benchmark test, just run this command : `agl-benchmark -s`.

NOTE: this feature is added by default on e3-emulation.xml from "AGL-repo" here : https://gerrit.automotivelinux.org/gerrit/gitweb?p=AGL/AGL-repo.git;a=blob;f=e3-emulation.xml;hb=refs/heads/sandbox/pmarzin/e3-emulation#l104

### E3 VS M3

```bash
                 E3                     V.S.             M3 DDR3200                            DDR3200 - (downgraded)                   DDR1600 - (downgraded)
######################################   |   ######################################   ######################################   ######################################
#   AGL Benchmarking script - v0.6   #   |   #   AGL Benchmarking script - v0.6   #   #   AGL Benchmarking script - v0.6   #   #   AGL Benchmarking script - v0.6   #
######################################   |   ######################################   ######################################   ######################################
                                         |
 Hardware information :                  |    Hardware information :                   Hardware information :                   Hardware information :
 * CPU : renesas R-Car Gen3 r8a77990     |    * CPU : renesas R-Car Gen3 r8a7796       * CPU : renesas R-Car Gen3 r8a7796       * CPU : renesas R-Car Gen3 r8a7796
   - Arch  : aarch64                     |      - Arch  : aarch64                        - Arch  : aarch64                        - Arch  : aarch64
   - Cores : 2/2                         |      - Cores : 6/6                            - Cores : 2/6                            - Cores : 2/6
   - Freq  : 1200 MHz                    |      - Freq  : 1500 MHz                       - Freq  : 1000 MHz                       - Freq  : 1000 MHz
   - Cache : 384 KB                      |      - Cache : 1952 KB                        - Cache : 1952 KB                        - Cache : 1952 KB
   - Bogo  : 48.00 MIPS                  |      - Bogo  : 16.66 MIPS                     - Bogo  : 16.66 MIPS                     - Bogo  : 16.66 MIPS
 * RAM : unknown                         |    * RAM : unknown                          * RAM : unknown                          * RAM : unknown
   - Size  : 1819 MB                     |      - Size  : 1756 MB                        - Size  : 1756 MB                        - Size  : 1756 MB
   - Speed : ?                           |      - Speed : ?                              - Speed : ?                              - Speed : ?
 * GPU : IMG PowerVR Series8XE GE8300    |    * GPU : IMG PowerVR Series6XT GX6250     * GPU : IMG PowerVR Series6XT GX6250     * GPU : IMG PowerVR Series6XT GX6250
   - Freq  : 600 MHz                     |      - Freq  : 600 MHz                        - Freq  : 200 MHz                        - Freq  : 200 MHz
                                         |
 Start benchmarking...                   |    Start benchmarking...                    Start benchmarking...                    Start benchmarking...
 * CPU Results :                         |    * CPU Results :                          * CPU Results :                          * CPU Results :
   - Stress-ng :   554 (2 core(s))       |      - Stress-ng :  2376 (6 core(s))          - Stress-ng :   728 (2 core(s))          - Stress-ng :   730 (2 core(s))
   - Stress-ng :  1152 (1 core)          |      - Stress-ng :  2680 (1 core)             - Stress-ng :  1760 (1 core)             - Stress-ng :  1768 (1 core)
   - Stress-ng :  1020 (crc16)           |      - Stress-ng :   940 (crc16)              - Stress-ng :   620 (crc16)              - Stress-ng :   620 (crc16)
   - Stress-ng :  1645 (cfloat)          |      - Stress-ng :  5030 (cfloat)             - Stress-ng :  3419 (cfloat)             - Stress-ng :  3421 (cfloat)
   - Stress-ng :   839 (double)          |      - Stress-ng :  1781 (double)             - Stress-ng :  1199 (double)             - Stress-ng :  1180 (double)
 * RAM Results :                         |    * RAM Results :                          * RAM Results :                          * RAM Results :
   - Write (dd):   377 (MB/s)            |      - Write (dd):   660 (MB/s)               - Write (dd):   526 (MB/s)               - Write (dd):   463 (MB/s)
   - Read  (dd):   641 (MB/s)            |      - Read  (dd):  1406 (MB/s)               - Read  (dd):  1292 (MB/s)               - Read  (dd):  1036 (MB/s)
 * GPU Results :                         |    * GPU Results :                          * GPU Results :                          * GPU Results :
   - glmark2   :   316                   |      - glmark2   :   795                      - glmark2   :   395                      - glmark2   :   387
                                         |
######################################   |   ######################################   ######################################   ######################################
# Your AGL Benchmarking score:   622 #   |   # Your AGL Benchmarking score:  1462 #   # Your AGL Benchmarking score:   949 #   # Your AGL Benchmarking score:   892 #
######################################   |   ######################################   ######################################   ######################################
# Score details:                     #   |   # Score details:                     #   # Score details:                     #   # Score details:                     #
#  * CPU:   347                      #   |   #  * CPU:   853                      #   #  * CPU:   515                      #   #  * CPU:   514                      #
#  * RAM:   169                      #   |   #  * RAM:   344                      #   #  * RAM:   303                      #   #  * RAM:   249                      #
#  * GPU:   106                      #   |   #  * GPU:   265                      #   #  * GPU:   131                      #   #  * GPU:   129                      #
######################################   |   ######################################   ######################################   ######################################

```