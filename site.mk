# --- Release Information

DEFAULT_GLUON_RELEASE := v2022.1.4-$(shell date '+%Y%m%d')-stable
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_DEPRECATED ?= 0

# Default priority for updates.
GLUON_PRIORITY ?= 5

# Region code required for some images; supported values: us eu
GLUON_REGION ?= eu

# languages to include in images
GLUON_LANGS ?= en de

# Prefer ath10k firmware with 802.11s support
GLUON_WLAN_MESH ?= 11s

# Build gluon with multidomain support.
GLUON_MULTIDOMAIN=1

#############################
# Default packages
#############################

# Future Features to consider
#	config-mode-geo-location-osm \

# Featureset, these are either virtual or packages prefixed with "gluon-"
GLUON_FEATURES := \
	autoupdater \
	authorized-keys \
	config-mode-domain-select \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	mesh-batman-adv-15 \
	mesh-vpn-tunneldigger \
	radv-filterd \
	radvd \
	respondd \
	status-page \
	web-advanced \
	web-logging \
	web-private-wifi \
	web-wizard \
	web-admin \
	wireless-encryption-wpa3

# Additional packages to install on every image
GLUON_SITE_PACKAGES := \
	iwinfo \
	respondd-module-airtime \
#	iptables gelöscht 2023
#	haveged  gelöscht 2020
	
#############################
# Additional package sets
#############################

# USB Human Interface
USB_PACKAGES_HID := \
	kmod-usb-hid \
	kmod-hid-generic

# USB Serial
USB_PACKAGES_SERIAL := \
	kmod-usb-serial \
	kmod-usb-serial-ftdi \
	kmod-usb-serial-pl2303

# USB Storage
USB_PACKAGES_STORAGE := \
	block-mount \
	blkid \
	kmod-fs-ext4 \
	kmod-fs-ntfs \
	kmod-fs-vfat \
	kmod-usb-storage \
	kmod-usb-storage-extras \
	kmod-nls-base \
	kmod-nls-cp1250 \
	kmod-nls-cp1251 \
	kmod-nls-cp437 \
	kmod-nls-cp850 \
	kmod-nls-cp852 \
	kmod-nls-iso8859-1 \
	kmod-nls-iso8859-13 \
	kmod-nls-iso8859-15 \
	kmod-nls-iso8859-2 \
	kmod-nls-utf8 \
	swap-utils

# USB Network
USB_PACKAGES_NET := \
	kmod-ath9k-htc \
	kmod-mii \
	kmod-nls-base \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-asix-ax88179 \
	kmod-usb-net-cdc-eem \
	kmod-usb-net-cdc-ether \
	kmod-usb-net-cdc-mbim \
	kmod-usb-net-cdc-subset \
	kmod-usb-net-dm9601-ether \
	kmod-usb-net-hso \
	kmod-usb-net-huawei-cdc-ncm \
	kmod-usb-net-ipheth \
	kmod-usb-net-kalmia \
	kmod-usb-net-kaweth \
	kmod-usb-net-mcs7830 \
	kmod-usb-net-pegasus \
	kmod-usb-net-qmi-wwan \
	kmod-usb-net-rndis \
	kmod-usb-net-rtl8152 \
	kmod-usb-net-sierrawireless \
	kmod-usb-net-smsc95xx

# PCI-Express Network
PCIE_PACKAGES_NET := \
	kmod-bnx2

# additional packages
TOOLS_PACKAGES := \
	iperf \
	socat \
	tcpdump \
	vnstat

USB_PACKAGES_MR3020 := \
	kmod-nls-base \
	kmod-usb-core \
	kmod-mii \
	kmod-usb-net \
	kmod-usb-net-cdc-ether \
	kmod-usb-net-rndis \
	kmod-usb-uhci


# Group previous package sets
USB_PACKAGES_WITHOUT_HID := \
	usbutils \
	usb-modeswitch \
	$(USB_PACKAGES_SERIAL) \
	$(USB_PACKAGES_STORAGE) \
	$(USB_PACKAGES_NET)

USB_PACKAGES := \
	$(USB_PACKAGES_HID) \
	$(USB_PACKAGES_WITHOUT_HID)

PCIE_PACKAGES := \
	pciutils \
	$(PCIE_PACKAGES_NET)

##################################
# Assign package sets to targets
##################################

# x86 Generic Purpose Hardware
ifeq ($(GLUON_TARGET),x86-generic)
	GLUON_SITE_PACKAGES += $(USB_PACKAGES) $(PCIE_PACKAGES) $(TOOLS_PACKAGES)
endif

ifeq ($(GLUON_TARGET),x86-64)
	GLUON_SITE_PACKAGES += $(USB_PACKAGES) $(PCIE_PACKAGES) $(TOOLS_PACKAGES)
endif

# PCEngines ALIX Boards
ifeq ($(GLUON_TARGET),x86-geode)
	GLUON_SITE_PACKAGES += $(USB_PACKAGES) $(PCIE_PACKAGES) $(TOOLS_PACKAGES)
endif

#  Raspberry Pi A/B/B+
ifeq ($(GLUON_TARGET),brcm2708-bcm2708)
	GLUON_SITE_PACKAGES += $(USB_PACKAGES)
endif

# Raspberry Pi 2
ifeq ($(GLUON_TARGET),brcm2708-bcm2709)
	GLUON_SITE_PACKAGES += $(USB_PACKAGES)
endif

# Raspberry Pi 3
ifeq ($(GLUON_TARGET),brcm2708-bcm2710)
        GLUON_SITE_PACKAGES += $(USB_PACKAGES)
endif

# Banana Pi/Pro, Lamobo R1
ifeq ($(GLUON_TARGET),sunxi)
	GLUON_SITE_PACKAGES += $(USB_PACKAGES)
endif


ifeq ($(GLUON_TARGET),ramips-mt76x8)
	GLUON_SITE_PACKAGES += $(USB_PACKAGES)
endif

# ar71xx-generic / tiny
GLUON_tp-link-archer-c7-v2_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_UMTS) $(USB_PACKAGES_STORAGE) $(USB_PACKAGES_NET) $(MISC_PACKAGES)
GLUON_tp-link-archer-c7-v4_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_UMTS) $(USB_PACKAGES_STORAGE) $(USB_PACKAGES_NET) $(MISC_PACKAGES)

# 842 can't install a full featured usb image, we don't need network and UMTS on our 842 devices

GLUON_tp-link-tl-wr1043n-nd-v1_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_UMTS) $(USB_PACKAGES_STORAGE) $(USB_PACKAGES_NET) $(MISC_PACKAGES)
GLUON_tp-link-tl-wr1043n-nd-v2_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_UMTS) $(USB_PACKAGES_STORAGE) $(USB_PACKAGES_NET) $(MISC_PACKAGES)
GLUON_tp-link-tl-wr1043n-nd-v3_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_UMTS) $(USB_PACKAGES_STORAGE) $(USB_PACKAGES_NET) $(MISC_PACKAGES)
GLUON_tp-link-tl-wr1043n-nd-v4_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_UMTS) $(USB_PACKAGES_STORAGE) $(USB_PACKAGES_NET) $(MISC_PACKAGES)

GLUON_tp-link-tl-wdr3500-v1_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_UMTS) $(USB_PACKAGES_STORAGE) $(USB_PACKAGES_NET) $(MISC_PACKAGES)
GLUON_tp-link-tl-wdr3600-v1_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_UMTS) $(USB_PACKAGES_STORAGE) $(USB_PACKAGES_NET) $(MISC_PACKAGES)
GLUON_tp-link-tl-wdr4300-v1_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_UMTS) $(USB_PACKAGES_STORAGE) $(USB_PACKAGES_NET) $(MISC_PACKAGES)

GLUON_tp-link-tl-mr3020-v1_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_MR3020) -gluon-status-page

# mpc85xx-generic

GLUON_tp-link-tl-wdr4900-v1_SITE_PACKAGES := $(USB_PACKAGES_BASIC) $(USB_PACKAGES_STORAGE) $(USB_PACKAGES_NET) $(MISC_PACKAGES)
