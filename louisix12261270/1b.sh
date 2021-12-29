echo "============================================="
echo "=== louisix12261270 / ArchLinux / 1b: v50 ==="
echo "============================================="

TITLECOLOR='\033[0;34m'
DEFAULTCOLOR='\033[0m'

title () {
  echo
  echo -e "${TITLECOLOR}$1${DEFAULTCOLOR}"
  echo
}

aftersection () {
    sleep 4
}

title "[B.01] === /etc/localtime ==="
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
aftersection

title "[B.02] === hwclock ==="
hwclock --systohc
aftersection

title "[B.03] === /etc/locale.gen and locale-gen ==="
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
aftersection

title "[B.04] === /etc/locale.conf ==="
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf
aftersection

title "[B.05] === /etc/vconsole.conf ==="
echo "KEYMAP=fr-latin1" > /etc/vconsole.conf
aftersection

title "[B.06] === /etc/hostname ==="
echo "louisix12261270" > /etc/hostname
aftersection

title "[B.07] === /etc/hosts ==="
touch /etc/hosts
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	louisix12261270" >> /etc/hosts
aftersection

title "[B.08] === pacman update ==="
pacman -Sy --noconfirm archlinux-keyring
pacman-key --noconfirm --populate archlinux
pacman-key --noconfirm --refresh-keys
pacman -Syu --noconfirm 
pacman -Scc --noconfirm 
pacman -Syuu --noconfirm
aftersection

title "[B.09] === root password ==="
echo "root:e" | chpasswd
aftersection

title "[B.10] === GRUB ==="
pacman -S --noconfirm grub os-prober
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
aftersection

title "[B.11] === networkmanager ==="
pacman -S --noconfirm networkmanager wpa_supplicant wireless_tools
systemctl enable wpa_supplicant.service
systemctl enable NetworkManager.service
aftersection

title "[B.12] === X, i3/lxdm/lxterminal/nm-applet/conky/nitrogen ==="
pacman -S --noconfirm xorg xorg-xinit xorg-xrandr xterm i3 lxterminal lxdm network-manager-applet conky nitrogen
systemctl enable lxdm

# sur ArchBang live, pour trouver le driver à installer:
#   $ lspci | grep VGA
# la liste des drivers pouvant être installés:
#   $ sudo pacman -Qq | grep xf86-video
pacman --noconfirm xf86-video-intel

###### TODO
### "Failed to set keymap: Local keyboard configuration not supported ..."
# X configuration: keyboard
# https://wiki.archlinux.org/title/Xorg/Keyboard_configuration

# libxkbcommon and libxkbcommon-x11 are required to set the keyboard:
# see e.g. https://www.reddit.com/r/archlinux/comments/if28wn/localectl_does_not_have_uk_keyboard_layout/
pacman --noconfirm libxkbcommon libxkbcommon-x11
localectl --no-convert set-x11-keymap fr pc105 keypad:pointerkeys grp:alt_shift_toggle

# link between lxdm and i3 configuration:
curl https://raw.githubusercontent.com/suizokukan/myarchlinux/main/louisix12261270/i3.desktop > i3.desktop
curl https://raw.githubusercontent.com/suizokukan/myarchlinux/main/louisix12261270/i3-with-shmlog.desktop > i3-with-shmlog.desktop
cp i3.desktop /usr/share/xsessions/
cp i3-with-shmlog.desktop /usr/share/xsessions/

aftersection

title "[B.13] === automount ==="
### https://doc.ubuntu-fr.org/autofs
### https://unix.stackexchange.com/questions/374103/systemd-automount-vs-autofs/375602#375602
### https://qastack.fr/unix/196397/is-there-anyway-to-automatically-mount-a-filesystem-when-i-open-a-symbolic-link
echo "UUID=ed5ac6e5-9fc3-4d28-b0b5-0c4466249c71 /mnt/mymnt ext4  noauto,nofail,x-systemd.automount,x-systemd.idle-timeout=2s,x-systemd.device-timeout=30ms" >> /etc/fstab
systemctl daemon-reload
systemctl daemon-reload
systemctl restart local-fs.target
aftersection

title "[B.14] === nano and emacs ==="
pacman -S --noconfirm nano emacs
aftersection

title "[B.15] === fish ==="
### chsh -s will be later called to change default shell for each new user.
pacman -S --noconfirm fish
aftersection

title "[B.16] === sudo, which, htop, tree, ntfs-3g, wget ==="
# https://wiki.archlinux.fr/Sudo
pacman -S --noconfirm sudo

pacman -S --noconfirm which htop tree ntfs-3g wget 
aftersection

title "[B.17] === firefox ==="
pacman -S --noconfirm firefox
aftersection

title "[B.18] === python ==="
sudo pacman -S --noconfirm base-devel python-pylint python-pip shellcheck
aftersection

title "[B.19] === thunar ==="
pacman -S --noconfirm thunar
aftersection

title "[B.20] === git ==="
pacman -S --noconfirm git

git config --global user.name "suizokukan"
git config --global user.email "suizokukan@orange.fr"
git config --global core.editor "emacs"
git config --global pull.rebase false

aftersection

title "[B.21] === yaourt ==="

rm -rf package-query/
rm -rf yaourt/
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si --noconfirm
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si --noconfirm
cd ..
rm -rf package-query/
rm -rf yaourt/

aftersection

title "[B.22] === fonts ==="
sudo pacman -S --noconfirm ttf-hanazono
aftersection

title "[B.23] === new user: proguser (sudoer) ==="
groupadd sudo
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

aftersection
