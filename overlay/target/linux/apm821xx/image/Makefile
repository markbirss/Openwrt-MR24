#
# Copyright (C) 2016 Chris Blake <chrisrblake93@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

DTS_TARGETS = ikarem

define Image/Prepare
	$(foreach dts,$(DTS_TARGETS),
		$(LINUX_DIR)/scripts/dtc/dtc -I dts -O dtb $(DTS_DIR)/$(dts).dts > $(KDIR)/$(IMG_PREFIX)-$(notdir $(dts)).fdt
	)
endef

define Image/BuildKernel
	cp $(KDIR)/uImage $(BIN_DIR)/$(IMG_PREFIX)-uImage
	cp $(KDIR)/zImage $(BIN_DIR)/$(IMG_PREFIX)-zImage
endef

define Image/BuildKernel/Initramfs
	cp $(KDIR)/uImage-initramfs $(BIN_DIR)/$(IMG_PREFIX)-initramfs-uImage
endef

define Image/Build/squashfs
	$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
	cp $(KDIR)/root.$(1) $(BIN_DIR)/$(IMG_PREFIX).squashfs
endef

define Image/Build/meraki
	$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
	( \
		dd if=$(KDIR)/$(IMG_PREFIX)-ikarem.fdt bs=63k conv=sync; \
		dd if=$(KDIR)/uImage bs=128k conv=sync; \
		dd if=$(KDIR)/root.$(1) bs=256k conv=sync; \
	) > $(BIN_DIR)/$(IMG_PREFIX)-$(2).img
	$(STAGING_DIR_HOST)/bin/mkmerakifw -B mr24 -i $(BIN_DIR)/$(IMG_PREFIX)-$(2).img -o $(BIN_DIR)/$(IMG_PREFIX)-$(2)-patched.img -s
endef

define Image/Build/Profile/MR24
	$(call Image/Build/meraki,$(1),mr24)
endef

define Image/Build/Profile/Default
	$(call Image/BuildKernel)
	$(call Image/Build/squashfs,$(1))
endef

define Image/Build
	$(call Image/Build/$(1),$(1))
	$(call Image/Build/Profile/$(PROFILE),$(1))
endef

$(eval $(call BuildImage))
