echo "============================================="
echo "=== louisix12261270 / ArchLinux / 1b: v28 ==="
echo "============================================="

echo
echo "[B.01] === /etc/localtime ==="
echo
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
sleep 2

echo
echo "[B.02] === hwclock ==="
echo
hwclock --systohc
sleep 2

echo
echo "[B.03] === /etc/locale.gen and locale-gen ==="
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen
echo
locale-gen
sleep 2

echo
echo "[B.04] === /etc/locale.conf ==="
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf
echo
sleep 2

echo
echo "[B.05] === /etc/vconsole.conf ==="
echo "KEYMAP=fr-latin1" > /etc/vconsole.conf
echo
sleep 2

echo
echo "[B.06] === /etc/hostname ==="
echo "louisix12261270" > /etc/hostname
echo
sleep 2

echo
echo "[B.07] === /etc/hosts ==="
echo
touch /etc/hosts
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	louisix12261270" >> /etc/hosts
sleep 2

echo
echo "[B.08] === pacman update ==="
echo

pacman -Sy --noconfirm archlinux-keyring
pacman-key --noconfirm --populate archlinux
pacman-key --noconfirm --refresh-keys
pacman -Syu --noconfirm 
pacman -Scc --noconfirm 
pacman -Syuu --noconfirm 

echo
echo "[B.09] === root password ==="
echo
echo "root:e" | chpasswd
sleep 2

echo
echo "[B.10] === GRUB ==="
echo
pacman -S --noconfirm grub os-prober
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
sleep 2

echo
echo "[B.11] === networkmanager ==="
echo
pacman -S --noconfirm networkmanager wpa_supplicant wireless_tools
systemctl enable wpa_supplicant.service
systemctl enable NetworkManager.service
sleep 2

echo
echo "[B.12] === X, i3 and conky ==="
echo
pacman -S --noconfirm xorg xorg-xinit xterm i3 conky
sleep 2

echo
echo "[B.13] === nano and emacs ==="
echo
pacman -S --noconfirm nano emacs
sleep 2

echo
echo "[B.14] === proguser ==="
echo
useradd -m proguser
echo "proguser:e" | chpasswd
sleep 2
