PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/orion/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/orion/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/orion/prebuilt/common/bin/50-orion.sh:system/addon.d/50-orion.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/orion/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Orion-specific init file
PRODUCT_COPY_FILES += \
    vendor/orion/prebuilt/common/etc/init.local.rc:root/init.orion.rc

# Copy latinime for gesture typing
PRODUCT_COPY_FILES += \
    vendor/orion/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/orion/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/orion/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/orion/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

PRODUCT_COPY_FILES += \
    vendor/orion/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/orion/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/orion/prebuilt/common/bin/sysinit:system/bin/sysinit

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    su
    
    # Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra Optional packages
PRODUCT_PACKAGES += \
    SlimOTA \
    SlimFileManager \
    LatinIME \
    BluetoothExt \
    DashClock \
    LockClock \
    Launcher3

#    orionFileManager removed until updated

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# SuperSU
PRODUCT_COPY_FILES += \
   vendor/orion/prebuilt/common/etc/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
   vendor/orion/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# Viper4Android
PRODUCT_COPY_FILES += \
   vendor/orion/prebuilt/common/bin/audio_policy.sh:install/bin/audio_policy.sh \
   vendor/orion/prebuilt/common/addon.d/91-v4a.sh:system/addon.d/91-v4a.sh \
   vendor/orion/prebuilt/common/etc/audio_effects.conf:system/etc/audio_effects.conf \
   vendor/orion/prebuilt/common/lib/soundfx/libv4a_fx_ics.so:system/lib/soundfx/libv4a_fx_ics.so \
   vendor/orion/prebuilt/common/su.d//15v4a.sh:system/su.d/15v4a.sh \
   vendor/orion/prebuilt/common/vendor/etc/audio_effects.conf:system/vendor/etc/audio_effects.conf
   vendor/orion/prebuilt/common/app/Viper4Android/Viper4Android.apk:system/priv-app/Viper4Android/Viper4Android.apk 

# Layers Manager
PRODUCT_COPY_FILES += \
vendor/orion/prebuilt/common/app/LayersManager/layersmanager.apk:system/app/LayersManager/layersmanager.apk

# Layers Backup
PRODUCT_COPY_FILES += \
vendor/orion/prebuilt/common/bin/71-layers.sh:system/addon.d/71-layers.sh
 
# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/orion/overlay/common

# Bootanimation support
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/bootanimation.zip:system/media/bootanimation.zip

# Versioning System
# OrionOS first version.
PRODUCT_VERSION_MAJOR = 6.0
PRODUCT_VERSION_MINOR = 2.0
PRODUCT_VERSION_MAINTENANCE = test
ifdef ORION_BUILD_EXTRA
    ORION_POSTFIX := -$(ORION_BUILD_EXTRA)
endif
ifndef ORION_BUILD_TYPE
ifeq ($(ORION_RELEASE),true)
    ORION_BUILD_TYPE := OFFICIAL
    PLATFORM_VERSION_CODENAME := OFFICIAL
    ORION_POSTFIX := -$(shell date +"%Y%m%d")
else
    ORION_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
    ORION_POSTFIX := -$(shell date +"%Y%m%d")
endif
endif

ifeq ($(ORION_BUILD_TYPE),DM)
    ORION_POSTFIX := -$(shell date +"%Y%m%d")
endif

ifndef ORION_POSTFIX
    ORION_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

PLATFORM_VERSION_CODENAME := $(ORION_BUILD_TYPE)

# OrionIRC
# export INCLUDE_ORIONIRC=1 for unofficial builds
ifneq ($(filter WEEKLY OFFICIAL,$(ORION_BUILD_TYPE)),)
    INCLUDE_ORIONIRC = 1
endif

ifneq ($(INCLUDE_ORIONIRC),)
    PRODUCT_PACKAGES += OrionIRC
endif

# Set all versions
ORION_VERSION := OrionOS-$(PRODUCT_VERSION_MINOR)-$(ORION_BUILD_TYPE)$(ORION_POSTFIX)
ORION_MOD_VERSION := OrionOS-$(ORION_BUILD)-$(PRODUCT_VERSION_MINOR)-$(ORION_BUILD_TYPE)$(ORION_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    orion.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.orion.version=$(ORION_VERSION) \
    ro.modversion=$(ORION_MOD_VERSION) \
    ro.orion.buildtype=$(ORION_BUILD_TYPE)

EXTENDED_POST_PROCESS_PROPS := vendor/orion/tools/orion_process_props.py


