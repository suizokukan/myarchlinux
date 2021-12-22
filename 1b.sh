echo "============================================"
echo "=== louisix12261270 / ArchLinux / 1b: v6 ==="
echo "============================================"

echo "[01] === /etc/localtime ==="
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
sleep 1

echo "[02] === hwclock ==="
hwclock --systohc
sleep 1

echo "[03] === /etc/locale.gen and locale-gen ==="
echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
sleep 1

echo "[04] === /etc/locale.conf ==="
echo "LANG=fr_FR.UTF-8" > /etc/locale.conf
echo "LC_MESSAGES=fr_FR.UTF-8" >> /etc/locale.conf
sleep 1

echo "[05] === /etc/vconsole.conf ==="
echo "KEYMAP=fr-latin1" > /etc/vconsole.conf
sleep 1

echo "[06] === /etc/hostname ==="
echo "louisix12261270" > /etc/hostname
sleep 1

echo "[07] === /etc/hosts ==="
touch /etc/hosts
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	louisix12261270" >> /etc/hosts
sleep 1

echo "[08] === DHCP ==="
systemctl enable dhcpcd
sleep 1

echo "[09] === root password ==="
echo "root:e" | chpasswd
sleep 1

echo "[10] === GRUB ==="
pacman -S --noconfirm grub os-prober
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
sleep 1

echo "[??] === proguser ==="
useradd -m proguser
echo "proguser:e" | chpasswd
sleep 1
