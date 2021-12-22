echo "========================================"
echo "=== louisix12261270 / ArchLinux / v3 ==="
echo "========================================"

echo "[01] === sfdisk /dev/sda < 1.sfdisk ==="
sfdisk /dev/sda < 1.sfdisk
sleep 1

echo "[02] === format ==="
mkfs.ext4 -F /dev/sda2
mkswap /dev/sda1
sleep 1

echo "[03] === mount and swapon ==="
mount /dev/sda2 /mnt
swapon /dev/sda1
sleep 1

echo "[04] === pacstrap ==="
pacstrap /mnt base linux linux-firmware nano
sleep 1

echo "[05] === /mnt/etc/fstab ==="
genfstab -U /mnt >> /mnt/etc/fstab
sleep 1

echo "[06] === arch-chroot /mnt ==="
arch-chroot /mnt
sleep 1

echo "[07] === /etc/localtime ==="
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
sleep 1

echo "[08] === hwclock ==="
hwclock --systohc
sleep 1

echo "[09] === /etc/locale.gen and locale-gen ==="
echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
sleep 1

echo "[10] === /etc/locale.conf ==="
echo "LANG=fr_FR.UTF-8" > /etc/locale.conf
echo "LC_MESSAGES=fr_FR.UTF-8" >> /etc/locale.conf
sleep 1

echo "[11] === /etc/vconsole.conf ==="
echo "KEYMAP=fr-latin1" > /etc/vconsole.conf
sleep 1

echo "[12] === /etc/hostname ==="
echo "louisix12261270" > /etc/hostname
sleep 1
