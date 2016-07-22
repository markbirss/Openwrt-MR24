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

Booting
-----
The MR24 comes with U-Boot, so you can boot an initramfs image using:
```
setenv netloadmethod tftpboot; setenv bootargs console=ttyS0,${baudrate} rootfstype=squashfs mtdoops.mtddev=oops; run meraki_load_net meraki_checkpart meraki_bootlinux
```
Note that the file will need to be named `mr24.bin` and it will need to be hosted by a TFTP server at 192.168.1.101/24

Flashing
-----
  1. Boot into U-Boot over UART
  2. Set the new U-Boot settings to boot our images. This will set the proper UBI partition names, disable initramfs loading for the kenel, and keep it for the recovery initramfs image.

  ```
  setenv meraki_load1 ubi read \${meraki_loadaddr} kernel

  setenv meraki_load2 ubi read \${meraki_loadaddr} recovery

  setenv meraki_bootkernel bootm \${meraki_loadaddr_kernel} - \${meraki_loadaddr_fdt}

  setenv openwrt_bootargs setenv bootargs console=ttyS0,\${baudrate} rootfstype=squashfs mtdoops.mtddev=oops

  setenv meraki_boot run meraki_ubi openwrt_bootargs\; run meraki_load1 meraki_checkpart meraki_bootkernel\; run meraki_load2 meraki_checkpart meraki_bootlinux

  saveenv
  ```

  3. Use the above Booting commands to boot into an initramfs build of OpenWRT using TFTP
  4. Once booted, find the UBI Volume ID of board-config. This is done with `ubinfo /dev/ubi0 -N board-config`
  5. Cleanup and move around UBI partitions for maximum space. Note that in this example, replace `XX` with the Volume ID for `board-config`:

  ```
  ubirmvol /dev/ubi0 -N part1
  ubirmvol /dev/ubi0 -N part2
  ubirmvol /dev/ubi0 -N storage
  dd if=/dev/ubi0_XX of=/tmp/board-config.img
  ubirmvol /dev/ubi0 -N board-config
  ubimkvol /dev/ubi0 -s 24KiB -N board-config
  ubiupdatevol /dev/ubi0_0 /tmp/board-config.img
  ```

  6. Create a recovery UBI partition. This will host an initramfs build so our board can have a failback image in case of a bad flash, or sysupgrade issue. Note you will first want to upload a copy of the initramfs image to the board (which can be done with SCP/HTTP Server). In the below tutorial note that the new partition is made to be just a bit larger than the initramfs image. You will want to do this as well.

  ```
  ls -alh /tmp/openwrt-apm821xx-generic-mr24-initramfs-kernel.bin
  ubimkvol /dev/ubi0 -s 5MiB -N recovery
  ubiupdatevol /dev/ubi0_1 /tmp/openwrt-apm821xx-generic-mr24-initramfs-kernel.bin
  ```
  7. Once done, you can now load up LuCI at 192.168.1.1, and use the sysupgrade option to flash the full image to the device using the sysupgrade file named `openwrt-apm821xx-generic-mr24-squashfs-sysupgrade.tar`. From this point on, any future updates/builds can just be flashed through LuCI.

To Do
-----
##### MR24
* Port to a current target (will need a subtarget for nand)

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
