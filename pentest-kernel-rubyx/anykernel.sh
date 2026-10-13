# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers
#
# Device  : Redmi Note 12 Pro+ 5G (rubyx)
#           Redmi Note 12 Pro 5G  (ruby)
#           Redmi Note 12 Discovery (rubyp)
# Kernel  : PentestKernel — MT6877 / Dimensity 1080
# ─────────────────────────────────────────────────

properties() { '
kernel.string=PentestKernel @ rubyx
do.devicecheck=1
do.modules=1
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=rubyx
device.name2=ruby
device.name3=rubyp
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; }

# ── Block device for boot partition ──────────────────────────
block=/dev/block/platform/bootdevice/by-name/boot

# rubyx uses A/B-style OTA structure but has a single boot slot
is_slot_device=0

ramdisk_compression=auto
patch_vbmeta_flag=auto

# Source AnyKernel3 core functions
. tools/ak3-core.sh

# ── Kernel flash ─────────────────────────────────────────────
split_boot
flash_boot
