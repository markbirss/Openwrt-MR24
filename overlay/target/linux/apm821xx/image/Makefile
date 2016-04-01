#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

IMAGE_PROFILE:=$(if $(PROFILE),$(PROFILE),Default)

DEVICE_VARS += DTS IMAGE_SIZE

define Image/cpiogz
	( cd $(TARGET_DIR); find . | cpio -o -H newc | gzip -9n >$(KDIR_TMP)/$(IMG_PREFIX)-rootfs.cpio.gz )
endef

define Build/copy-file
	cat "$(1)" > "$@"
endef

define Build/MerakiAdd-dtb
        $(call Image/BuildDTB,../dts/$(DTS).dts,$@.dtb)
	( \
		dd if=$@.dtb bs=$(DTB_SIZE) conv=sync; \
		dd if=$@ bs=$(BLOCKSIZE) conv=sync; \
	) > $@.new
	@mv $@.new $@
endef

define Build/MerakiAdd-initramfs
	$(call Image/cpiogz)

	-$(STAGING_DIR_HOST)/bin/mkimage -A $(LINUX_KARCH) -O linux -T ramdisk \
		-C gzip -n "$(PROFILE) OpenWRT rootfs" \
		-d $(KDIR_TMP)/$(IMG_PREFIX)-rootfs.cpio.gz \
		$(KDIR_TMP)/$(IMG_PREFIX)-uramdisk.image.gz

	( \
		dd if=$@ bs=1k conv=sync; \
		dd if=$(KDIR_TMP)/$(IMG_PREFIX)-uramdisk.image.gz bs=$(BLOCKSIZE) conv=sync; \
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
  BOARDNAME :=
  DEVICE_PROFILE = $$(BOARDNAME)
  PROFILES = Default $$(DEVICE_PROFILE)
  KERNEL_DEPENDS = $$(wildcard ../dts/$$(DTS).dts)
  KERNEL := kernel-bin | lzma | uImage lzma
  KERNEL_INITRAMFS := kernel-bin | lzma | uImage lzma
endef
TARGET_DEVICES += Default

define Device/mr24
  BOARDNAME = MR24
  BLOCKSIZE := 64k
  IMAGES := sysupgrade.tar
  DTS := MR24
  DTB_SIZE := 63k
  KERNEL_SIZE := 2048k
  IMAGE_SIZE := 8191k
  KERNEL_ENTRY := 0x00000000
  KERNEL_LOADADDR := 0x00000000
  KERNEL := kernel-bin | gzip | uImage gzip | MerakiAdd-dtb | MerakiNAND
  KERNEL_INITRAMFS := copy-file $(KDIR)/vmlinux | gzip | uImage gzip | MerakiAdd-dtb | pad-to 2047k | MerakiAdd-initramfs | MerakiNAND
  IMAGE/sysupgrade.tar := sysupgrade-nand

endef
TARGET_DEVICES += mr24

$(eval $(call BuildImage))
