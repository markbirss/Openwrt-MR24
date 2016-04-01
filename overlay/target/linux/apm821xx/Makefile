#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=powerpc
BOARD:=apm821xx
BOARDNAME:=AppliedMicro APM821xx
CPU_TYPE:=464fp
FEATURES:=squashfs nand rtc fpu ramdisk
MAINTAINER:=Imre Kaloz <kaloz@openwrt.org>

KERNEL_PATCHVER:=4.4

include $(INCLUDE_DIR)/target.mk

KERNELNAME:=uImage

DEFAULT_PACKAGES += \
	kmod-leds-gpio kmod-booke-wdt wpad-mini

define Target/Description
	Build images for AppliedMicro APM821xx based boards.
endef

$(eval $(call BuildTarget))
