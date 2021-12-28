echo "============================================="
echo "=== louisix12261270 / ArchLinux / 1b: v41 ==="
echo "============================================="

echo
echo "[B.01] === /etc/localtime ==="
echo
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
sleep 4

echo
echo "[B.02] === hwclock ==="
echo
hwclock --systohc
sleep 4

echo
echo "[B.03] === /etc/locale.gen and locale-gen ==="
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen
echo
locale-gen
sleep 4

echo
echo "[B.04] === /etc/locale.conf ==="
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf
echo
sleep 4

echo
echo "[B.05] === /etc/vconsole.conf ==="
echo "KEYMAP=fr-latin1" > /etc/vconsole.conf
echo
sleep 4

echo
echo "[B.06] === /etc/hostname ==="
echo "louisix12261270" > /etc/hostname
echo
sleep 4

echo
echo "[B.07] === /etc/hosts ==="
echo
touch /etc/hosts
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	louisix12261270" >> /etc/hosts
sleep 4

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
sleep 4

echo
echo "[B.10] === GRUB ==="
echo
pacman -S --noconfirm grub os-prober
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
sleep 4

echo
echo "[B.11] === networkmanager ==="
echo
pacman -S --noconfirm networkmanager wpa_supplicant wireless_tools
systemctl enable wpa_supplicant.service
systemctl enable NetworkManager.service
sleep 4

echo
echo "[B.12] === X, i3/lxdm/lxterminal/nm-applet/conky/nitrogen ==="
echo
pacman -S --noconfirm xorg xorg-xinit xterm i3 lxterminal lxdm network-manager-applet conky nitrogen
systemctl enable lxdm

# sur ArchBang live, pour trouver le driver à installer:
#   $ lspci | grep VGA
# la liste des drivers pouvant être installés:
#   $ sudo pacman -Qq | grep xf86-video
pacman --no-confirm xf86-video-intel

# X configuration: keyboard
# https://wiki.archlinux.org/title/Xorg/Keyboard_configuration
localectl --no-convert set-x11-keymap fr pc105 keypad:pointerkeys grp:alt_shift_toggle

# link between lxdm and i3 configuration:
curl https://raw.githubusercontent.com/suizokukan/myarchlinux/main/louisix12261270/i3.desktop > i3.desktop
curl https://raw.githubusercontent.com/suizokukan/myarchlinux/main/louisix12261270/i3-with-shmlog.desktop > i3-with-shmlog.desktop
cp i3.desktop /usr/share/xsessions/
cp i3-with-shmlog.desktop /usr/share/xsessions/

sleep 4

echo
echo "[B.13] === nano and emacs ==="
echo
pacman -S --noconfirm nano emacs
sleep 4

echo
echo "[B.14] === fish ==="
echo
### chsh -s will be later called to change default shell for each new user.
pacman -S --noconfirm fish
sleep 4

echo
echo "[B.15] === sudo, which ==="
echo
pacman -S --noconfirm sudo which
sleep 4

echo
echo "[B.16] === firefox ==="
echo
pacman -S --noconfirm firefox
sleep 4

echo
echo "[B.17] === thunarx ==="
echo
pacman -S --noconfirm thunar
sleep 4

echo
echo "[B.17] === new user: proguser (sudoer) ==="
echo
useradd -m proguser
usermod -aG sudo proguser
echo "proguser:e" | chpasswd
chsh -s `which fish` proguser

# .config/i3/config file (stored in the repo as i3.config)
mkdir /home/proguser/.config
mkdir /home/proguser/.config/i3

curl https://raw.githubusercontent.com/suizokukan/myarchlinux/main/louisix12261270/i3.config > i3.config
cp i3.config /home/proguser/.config/i3/config

chown -R proguser /home/proguser/.config

sleep 4
