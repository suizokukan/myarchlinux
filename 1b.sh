echo "============================================="
echo "=== louisix12261270 / ArchLinux / 1b: v11 ==="
echo "============================================="

echo
echo "[01] === /etc/localtime ==="
echo
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
sleep 2

echo
echo "[02] === hwclock ==="
echo
hwclock --systohc
sleep 2

echo
echo "[03] === /etc/locale.gen and locale-gen ==="
echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen
echo
locale-gen
sleep 2

echo
echo "[04] === /etc/locale.conf ==="
echo "LANG=fr_FR.UTF-8" > /etc/locale.conf
echo "LC_MESSAGES=fr_FR.UTF-8" >> /etc/locale.conf
echo
sleep 2

echo
echo "[05] === /etc/vconsole.conf ==="
echo "KEYMAP=fr-latin1" > /etc/vconsole.conf
echo
sleep 2

echo
echo "[06] === /etc/hostname ==="
echo "louisix12261270" > /etc/hostname
echo
sleep 2

echo
echo "[07] === /etc/hosts ==="
echo
touch /etc/hosts
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	louisix12261270" >> /etc/hosts
sleep 2

echo
echo "[08] === DHCP ==="
echo
pacman -S --noconfirm dhcpcd
systemctl enable dhcpcd

pacman -S --noconfirm networkmanager
systemctl enable NetworkManager
sleep 2

echo
echo "[09] === root password ==="
echo
echo "root:e" | chpasswd
sleep 2

echo
echo "[10] === GRUB ==="
echo
pacman -S --noconfirm grub os-prober
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
sleep 2

echo
echo "[11] === networkmanager ==="
echo
pacman -S --noconfirm networkmanager
systemctl enable NetworkManager
sleep 2

echo
echo "[12] === i3 ==="
echo
pacman -S --noconfirm i3
sleep 2


echo
echo "[??] === proguser ==="
echo
useradd -m proguser
echo "proguser:e" | chpasswd
sleep 2
