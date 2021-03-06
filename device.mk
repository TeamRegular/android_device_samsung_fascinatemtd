# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# This file is the device-specific product definition file for
# crespo. It lists all the overlays, files, modules and properties
# that are specific to this hardware: i.e. those are device-specific
# drivers, configuration files, settings, etc...

# Note that crespo is not a fully open device. Some of the drivers
# aren't publicly available in all circumstances, which means that some
# of the hardware capabilities aren't present in builds where those
# drivers aren't available. Such cases are handled by having this file
# separated into two halves: this half here contains the parts that
# are available to everyone, while another half in the vendor/ hierarchy
# augments that set with the parts that are only relevant when all the
# associated drivers are available. Aspects that are irrelevant but
# harmless in no-driver builds should be kept here for simplicity and
# transparency. There are two variants of the half that deals with
# the unavailable drivers: one is directly checked into the unreleased
# vendor tree and is used by engineers who have access to it. The other
# is generated by setup-makefile.sh in the same directory as this files,
# and is used by people who have access to binary versions of the drivers
# but not to the original vendor tree. Be sure to update both.


# These are the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.
DEVICE_PACKAGE_OVERLAYS := device/samsung/fascinatemtd/overlay

PRODUCT_CHARACTERISTICS := 

# ramdisk files
PRODUCT_COPY_FILES += \
	device/samsung/fascinatemtd/init.aries.rc:root/init.aries.rc \

# hak
PRODUCT_COPY_FILES += \
	device/samsung/aries-common/bml_over_mtd.sh:bml_over_mtd.sh

# ppp
PRODUCT_COPY_FILES += \
	device/samsung/fascinatemtd/ip-up:system/etc/ppp/ip-up

# audio
PRODUCT_COPY_FILES += \
	device/samsung/fascinatemtd/libaudio/audio_policy.conf:system/etc/audio_policy.conf

# Device-specific packages
PRODUCT_PACKAGES += \
	Torch

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml

# Generic CDMA stuff
PRODUCT_PROPERTY_OVERRIDES += \
       ro.telephony.default_network=4 \
       ro.ril.def.agps.mode=2 \
       ro.cdma.homesystem=64,65,76,77,78,79,80,81,82,83 \
       ro.cdma.data_retry_config=default_randomization=2000,0,0,120000,180000,540000,960000 \
       ro.cdma.otaspnumschema=SELC,3,00,07,80,87,88,99 \
       ro.config.vc_call_vol_steps=15 \
       net.cdma.pppd.authtype=require-chap \
       net.cdma.datalinkinterface=/dev/ttyCDMA0 \
       net.cdma.ppp.interface=ppp0 \
       net.connectivity.type=CDMA1 \
       net.interfaces.defaultroute=cdma \
       mobiledata.interfaces=ppp0 \
       ro.ril.samsung_cdma=true \
       ro.telephony.ril.v3=datacall

# Verizon cdma stuff
PRODUCT_PROPERTY_OVERRIDES += \
       ro.cdma.home.operator.numeric=310004 \
       ro.cdma.home.operator.alpha=Verizon \
       net.cdma.pppd.user=user[SPACE]VerizonWireless

# decoy recovery kernel
PRODUCT_COPY_FILES += \
    device/samsung/fascinatemtd/recovery_kernel:recovery_kernel

# Inherit Aries common device configuration.
$(call inherit-product, device/samsung/aries-common/device_base.mk)

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/samsung/fascinatemtd/fascinatemtd-vendor.mk)
