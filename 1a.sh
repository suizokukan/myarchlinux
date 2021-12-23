echo "============================================"
echo "=== louisix12261270 / ArchLinux / 1a: v8 ==="
echo "============================================"

echo
echo "[01] === sfdisk /dev/sda < 1.sfdisk ==="
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
echo "[02] === format ==="
echo
mkfs.ext4 -F /dev/sda2
mkswap /dev/sda1
sleep 2

echo
echo "[03] === mount and swapon ==="
echo
mount /dev/sda2 /mnt
swapon /dev/sda1
sleep 2

echo
echo "[04] === pacstrap ==="
echo

pacman -Syy

pacman -S --noconfirm reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
reflector -c "fr" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist

pacstrap /mnt base linux linux-firmware nano networkmanager

pacman -Sy --noconfirm archlinux-keyring
pacman-key --noconfirm --populate archlinux
pacman-key --noconfirm --refresh-keys
pacman -Syu --noconfirm 
pacman -Scc --noconfirm 
pacman -Syuu --noconfirm 

sleep 2

echo
echo "[05] === /mnt/etc/fstab ==="
echo
genfstab -U /mnt >> /mnt/etc/fstab
sleep 2

echo
echo "[06] === arch-chroot /mnt ==="
echo
arch-chroot /mnt
sleep 2
