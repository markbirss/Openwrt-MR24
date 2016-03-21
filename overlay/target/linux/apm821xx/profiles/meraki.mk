#
# Copyright (C) 2016 Chris Blake (chrisrblake93@gmail.com)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/MR24
	NAME:=Meraki MR24
	PACKAGES:=kmod-spi-gpio kmod-gpio-button-hotplug
endef

define Profile/MR24/description
	Package set optimized for the Cisco Meraki MR24 Access Point.
endef

$(eval $(call Profile,MR24))
