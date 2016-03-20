# Openwrt-MR24

Bringup repo for the Cisco Meraki MR24 on OpenWRT!

Currently based on commit http://git.openwrt.org/?p=openwrt.git;a=commit;h=07c8b04a0b71fc2e6df0fa9458ef56a2f171f61d

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
setenv netloadmethod tftpboot; run meraki_load_net; setenv bootargs console=ttyS0,115200 rootfstype=squashfs panic=10 earlyprink mtdoops.mtddev=oops; bootm ${meraki_loadaddr_kernel} - ${meraki_loadaddr_fdt}
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
