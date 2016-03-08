# Openwrt-MR24

Bringup repo for the Cisco Meraki MR24 on OpenWRT!

Currently based on commit http://git.openwrt.org/?p=openwrt.git;a=commit;h=63bce15a60d6a307540662f87ce1b2515c553800

Building
-----
#### Build Only
`./build.sh`

#### Modify Configs and Build
`./build.sh modify`

Note that you will need to run a modify on the first compile to select the ppc44x image in the OpenWRT menuconfig.

To Do
-----
##### MR24
* Sysupgrade
* WiFi
* Ethernet
* LED's/GPIOs
* System Integration
* Kernel Device Profile
* Kernel Header Generation
* Determine NAND layout

Working
-----
##### MR24
 * Nothing

Notice
------
No promises this won't brick your AP, and no promises that this will even work!
