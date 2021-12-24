echo "============================================="
echo "=== louisix12261270 / ArchLinux / 1a: v17 ==="
echo "============================================="

echo
echo "[A.01] === sfdisk /dev/sda < 1.sfdisk ==="
echo

touch data.sfdisk
echo "label: dos" >> data.sfdisk
echo "label-id: 0xfac4ed85" >> data.sfdisk
echo "device: /dev/sda" >> data.sfdisk
echo "unit: sectors" >> data.sfdisk
echo "sector-size: 512" >> data.sfdisk
echo "" >> data.sfdisk
echo "/dev/sda1 : start=        2048, size=     4194304, type=82, bootable" >> data.sfdisk
echo "/dev/sda2 : start=     4196352, size=   620946096, type=83" >> data.sfdisk

sfdisk /dev/sda < data.sfdisk
sleep 2

echo
echo "[A.02] === format ==="
echo
mkfs.ext4 -F /dev/sda2
mkswap /dev/sda1
sleep 2

echo
echo "[A.03] === mount and swapon ==="
echo
mount /dev/sda2 /mnt
swapon /dev/sda1
sleep 2

echo
echo "[A.04] === pacstrap ==="
echo

curl https://raw.githubusercontent.com/suizokukan/myarchlinux/main/1.mirrorlist > 1.mirrorlist
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
cp 1.mirrorlist /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist

pacman -Syy

pacstrap /mnt base linux linux-firmware

sleep 2

echo
echo "[A.05] === /mnt/etc/fstab ==="
echo
genfstab -U /mnt >> /mnt/etc/fstab
sleep 2

echo
echo "[A.06] === arch-chroot /mnt ==="
echo
curl https://raw.githubusercontent.com/suizokukan/myarchlinux/main/1b.sh > 1b.sh
cp 1b.sh /mnt

echo "about to chroot on /mnt ..."
sleep 5
arch-chroot /mnt sh 1b.sh

