echo "============================================"
echo "=== louisix12261270 / ArchLinux / 1a: v3 ==="
echo "============================================"

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
