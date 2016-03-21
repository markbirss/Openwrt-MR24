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
CPU_TYPE:=464
FEATURES:=squashfs nand rtc
MAINTAINER:=Chris Blake <chrisrblake93@gmail.com>
SUBTARGETS=generic

KERNEL_PATCHVER:=4.4

include $(INCLUDE_DIR)/target.mk

KERNELNAME:=uImage zImage

DEFAULT_PACKAGES += \
	kmod-input-core kmod-input-gpio-keys kmod-button-hotplug \
	kmod-leds-gpio kmod-booke-wdt swconfig kmod-ath9k\
	wpad-mini

define Target/Description
	Build images for AppliedMicro APM821xx based boards.
endef

$(eval $(call BuildTarget))
