#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

DEVICE_VARS += DTS IMAGE_SIZE

define Build/MerakiAdd-dtb
        $(call Image/BuildDTB,../dts/$(DTS).dts,$@.dtb)
	( \
		dd if=$@.dtb bs=$(DTB_SIZE) conv=sync; \
		dd if=$@ bs=$(BLOCKSIZE) conv=sync; \
	) > $@.new
	@mv $@.new $@
endef

define Build/MerakiAdd-initramfs
	$(call Image/mkfs/cpiogz)

	-$(STAGING_DIR_HOST)/bin/mkimage -A powerpc -T ramdisk -C gzip -n "$(PROFILE) OpenWRT rootfs" \
		-d $(BIN_DIR)/$(IMG_PREFIX)-rootfs.cpio.gz \
		$(BIN_DIR)/$(IMG_PREFIX)-uramdisk.image.gz

	( \
		dd if=$@ bs=1k conv=sync; \
		dd if=$(BIN_DIR)/$(IMG_PREFIX)-uramdisk.image.gz bs=$(BLOCKSIZE) conv=sync; \
	) > $@.new
	@mv $@.new $@
endef

define Build/MerakiNAND
	-$(STAGING_DIR_HOST)/bin/mkmerakifw \
		-B $(BOARDNAME) -s \
		-i $@ \
		-o $@.new
	@cp $@.new $@
endef

define Device/Default
  KERNEL_DEPENDS = $$(wildcard ../dts/$$(DTS).dts)
  KERNEL := kernel-bin | lzma | uImage lzma
endef

define Device/mr24
  BOARDNAME = MR24
  BLOCKSIZE := 64k
  IMAGES := sysupgrade.tar initramfs.bin
  DTS := MR24
  DTB_SIZE := 63k
  KERNEL_SIZE := 1984k
  IMAGE_SIZE := 8191k
  KERNEL := kernel-bin | gzip | uImage gzip | MerakiAdd-dtb | MerakiNAND
  IMAGE/sysupgrade.tar := sysupgrade-nand
  IMAGE/initramfs.bin := kernel-bin | gzip | uImage gzip | MerakiAdd-dtb | pad-to 2047k | MerakiAdd-initramfs | MerakiNAND
endef
TARGET_DEVICES += mr24

$(eval $(call BuildImage))
