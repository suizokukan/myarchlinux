echo "louisix12261270 / ArchLinux / v1"
sfdisk /dev/sda < 1.sfdisk

mkfs.ext4 /dev/sda2
mkswap /dev/sda1

mount /dev/sda2 /mnt
swapon /dev/sda1

pacstrap base linux linux-firmware nano

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Region/City /etc/localtime

hwclock --systohc

echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen
locale-gen

echo "LANG=fr_FR.UTF-8" > /etc/locale.conf
echo "LC_MESSAGES=fr_FR.UTF-8" >> /etc/locale.conf

echo "KEYMAP=fr-latin1" > /etc/vconsole.conf

echo "louisix12261270" > /etc/hostname
