echo "louisix12261270 / ArchLinux / v2"

echo "[01] === sfdisk /dev/sda < 1.sfdisk ==="
sfdisk /dev/sda < 1.sfdisk

echo "[02] === format ==="
mkfs.ext4 -F /dev/sda2
mkswap /dev/sda1

echo "[03] === mount and swapon ==="
mount /dev/sda2 /mnt
swapon /dev/sda1

echo "[04] === pacstrap ==="
pacstrap base linux linux-firmware nano

echo "[05] === /mnt/etc/fstab ==="
genfstab -U /mnt >> /mnt/etc/fstab

echo "[06] === arch-chroot /mnt ==="
arch-chroot /mnt

echo "[07] === /etc/localtime ==="
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime

echo "[08] === hwclock ==="
hwclock --systohc

echo "[09] === /etc/locale.gen and locale-gen ==="
echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen
locale-gen

echo "[10] === /etc/locale.conf ==="
echo "LANG=fr_FR.UTF-8" > /etc/locale.conf
echo "LC_MESSAGES=fr_FR.UTF-8" >> /etc/locale.conf

echo "[11] === /etc/vconsole.conf ==="
echo "KEYMAP=fr-latin1" > /etc/vconsole.conf

echo "[12] === /etc/hostname ==="
echo "louisix12261270" > /etc/hostname
