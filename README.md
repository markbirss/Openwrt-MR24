# Openwrt-MR24

Bringup repo for the Cisco Meraki MR24 on OpenWRT!

Currently based on commit http://git.openwrt.org/?p=openwrt.git;a=commit;h=54eb6ade49863de101866981e917e732fc75d4e3

Building
-----
#### Build Only
`./build.sh`

#### Modify Configs and Build
`./build.sh modify`

Note that you will need to run a modify on the first compile to select the ppc44x image in the OpenWRT menuconfig.

Booting
-----
The MR24 comes with U-Boot, so you can boot an image using:
```
setenv netloadmethod tftpboot; run meraki_load_net; setenv bootargs root=/dev/ram console=ttyS0,${baudrate} ubi.mtd=ubi panic=10 earlyprink mtdoops.mtddev=oops; run meraki_bootlinux
```

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
