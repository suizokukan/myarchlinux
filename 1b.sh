echo "============================================="
echo "=== louisix12261270 / ArchLinux / 1b: v13 ==="
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
echo "[08] === pacman update ==="
echo

pacman -Sy --noconfirm archlinux-keyring
pacman-key --noconfirm --populate archlinux
pacman-key --noconfirm --refresh-keys
pacman -Syu --noconfirm 
pacman -Scc --noconfirm 
pacman -Syuu --noconfirm 


echo
echo "[09] === network ==="
echo

pacman -S --noconfirm networkmanager
systemctl enable NetworkManager
sleep 2

echo
echo "[10] === root password ==="
echo
echo "root:e" | chpasswd
sleep 2

echo
echo "[11] === GRUB ==="
echo
pacman -S --noconfirm grub os-prober
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
sleep 2

echo
echo "[12] === networkmanager ==="
echo
pacman -S --noconfirm networkmanager
systemctl enable NetworkManager
sleep 2

echo
echo "[13] === i3 and conky ==="
echo
pacman -S --noconfirm i3 conky
sleep 2

echo
echo "[14] === emacs ==="
echo
pacman -S --noconfirm emacs
sleep 2

echo
echo "[15] === proguser ==="
echo
useradd -m proguser
echo "proguser:e" | chpasswd
sleep 2
