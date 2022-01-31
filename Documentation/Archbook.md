# Archbook

## Device Description

MacBook Pro(Retina, 13-inch, Early 2015)

Processor:	2,7 Ghz Dual-Core Intel Core i5
Memory:		8 GB 1867 Mhz DDR3
Graphics:	Intel Iris Graphics 6100 1536 MB
Keyboard:	en_US

## Description

Dual boot OSX + Lvm on LUks grub Arch

> It is advisable to keep OS X installed, because MacBook firmware updates can only be installed using OS X.

## Procedure

### From OS X

#### [Firmware update](https://wiki.archlinux.org/title/Mac#Firmware_updates)
1. Open App Store
2. Check for updates
3. Install any updates
4. Reboot and perform step 1-3 until no updates are found.

#### [Partitions](https://wiki.archlinux.org/title/Mac#Partitions)
> [...] if you plan on keeping OS X for dual booting, you should consider that, by default, a MacBook's drive is formatted using GPT and contains at least **3 partitions**:
> **EFI**: the ~200 MB EFI system partition.
> **OS X**: the main partition containing your OS X installation. It is formatted using HFS+.
> **Recovery**: A recovery partition present in almost all MacBooks running OS X 10.7 or newer. It is usually hidden from OS X but can be viewed with partitioning tools.

1. Open Disk Utility.app
2. Select **the drive** (the volume) to be partitioned in the left-hand column. 
3. Click on the Partition button.
4. Add a new partition by pressing the **+** button 
5. Choose **the size** for the new partition.
6. Apply

> The new partition will be formatted in Arch Linux, you can choose **any format** you want.

### [LiveUSB](https://wiki.archlinux.org/title/USB_flash_installation_medium)

#### Boot the live environment
1. Shutdown
2. Hold **Alt** during boot
3. Select Efi
3. Select Arch Linux install medium

#### Live environment

##### Verify the boot mode
1. ls /sys/firmware/efi/efivars

##### Keyboard layout ($lang = FR)
1. localectl list-keymaps | grep $lang
2. loadkeys $keymap

##### Connect to the wifi using [iwctl](https://wiki.archlinux.org/title/Iwd) ($device = wlan0)
1. ip link
  + ip link set $device down
  + ip link set $device up
2. iwctl device list
3. iwctl station $device scan
3. iwctl station $device get-networks
4. iwctl station $device connect $ssid
  + iwctl --passphrase $passphrase station $device connect $ssid
  + iwctl --passphrase $passphrase station $device connect-hidden $ssid
5. ping archlinux.org

##### Update the system clock
1. timedatectl set-ntp true

##### Reflector?

##### Partition the disk ($block-device = sda3)
1. lsblk
2. fdisk -l

#### Wipe the disk (dm-crypt)
1. cryptsetup open --type plain -d /dev/urandom /dev/$block-device to_be_wiped
2. lsblk
3. dd if=/dev/zero of=/dev/mapper/to_be_wiped bs=1M status=progress
4. cryptsetup close to_be_wiped


##### Preparing the disk

1. cryptsetup luksFormat /dev/sda3

Disk format:

```
+-----------------------------------------------------------------------+ +----------------+
| Logical volume 1      | Logical volume 2      | Logical volume 3      | | Boot partition |
|                       |                       |                       | |                |
| [SWAP]                | /                     | /home                 | | /boot          |
|                       |                       |                       | |                |
| /dev/arch/swap        | /dev/arch/root        | /dev/arch/home        | |                |
|_ _ _ _ _ _ _ _ _ _ _ _|_ _ _ _ _ _ _ _ _ _ _ _|_ _ _ _ _ _ _ _ _ _ _ _| | (may be on     |
|                                                                       | | other device)  |
|                         LUKS2 encrypted partition                     | |                |
|                           /dev/sda3                                   | | /dev/sda1      |
+-----------------------------------------------------------------------+ +----------------+
```

##### Preparing the logical volumes

1. cryptsetup open /dev/sda3 cryptlvm

Create a physical volume on top of the opened LUKS container:

1. pvcreate /dev/mapper/cryptlvm

Create a volume group

1. vgcreate arch /dev/mapper/cryptlvm

Create all your logical volumes on the volume group: 

1. lvcreate -L 8G arch -n swap
2. lvcreate -L 32G arch -n root
3. lvcreate -l 100%FREE arch -n home

Format your filesystems on each logical volume:

1. mkfs.ext4 /dev/arch/root
2. mkfs.ext4 /dev/arch/home
3. mkswap /dev/arch/swap

Mount your filesystems:

1. mount /dev/arch/root /mnt
2. mkdir /mnt/home
3. mount /dev/arch/home /mnt/home
4. swapon /dev/arch/swap

Prepare the boot partition

1. mkdir /mnt/boot
2. mount /dev/sda1 /mnt/boot 

Check

1. lsblk


# Pacstrap
1.pacstrap /mnt base linux linux-firmware gvim intel-ucode lvm2

### Configure the system

1. genfstab -U /mnt >> /mnt/etc/fstab
2. arch-chroot /mnt
##### Chroot


Resources: 
[Mac](https://wiki.archlinux.org/title/Mac)
[Installation_guide](https://wiki.archlinux.org/title/Installation_guide)
[Dm-crypt](https://wiki.archlinux.org/title/Dm-crypt)
https://www.youtube.com/watch?v=kD3WC-93jEk
https://www.youtube.com/watch?v=x0Qmaa38UM8


Base installation
mkinitcpio
grub
lvm2

boot
