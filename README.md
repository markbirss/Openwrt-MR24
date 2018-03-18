# LEDE-MR24

**Note:** This repo is outdated, and the Meraki MR24 was merged into LEDE as of commit https://git.lede-project.org/?p=source.git;a=commit;h=a57d6e2d47688cfa392d6ea7f36ae6f9d84affc5 Note the flashing guide below still applies!

----

# Openwrt-MR24

Bringup repo for the Cisco Meraki MR24 on OpenWRT!

Currently based on commit http://git.openwrt.org/?p=openwrt.git;a=commit;h=2032cd1ba50b9c07ce0586c39d8b4ce59284c973

Building
-----
#### Build Only
`./build.sh`

#### Modify Configs and Build
`./build.sh modify`

Note that you will need to run a modify on the first compile to select the apm821xx target, MR24 device in the OpenWRT menuconfig.

Booting & Flashing
-----
Please refer to the [OpenWRT Wiki](https://openwrt.org/toh/meraki/mr24#flashing) for the latest flashing and booting documentation.

To Do
-----
##### MR24
* You tell me!

Working
-----
##### MR24
* WiFi
* Ethernet
* LED's/GPIOs
* Reset button
* System Integration
* Sysupgrade Support
* Kernel Device Profile
* Kernel Header Generation

Notice
------
No promises this won't brick your AP, and no promises that this will even work!
