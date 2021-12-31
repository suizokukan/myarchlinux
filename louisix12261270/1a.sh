#!/usr/bin/env bash


SCRIPTNAME="louisix12261270"
VERSION="v. 34"

showarguments() {
    echo "  -  --start"
    echo "  -  --chroot"
    echo "  -  -h / --help   : see this message."
    echo "  -  -v / --version: see version string."
}


# ---- --help ----------------------------------------------------------------
if [[ $# -eq 0 ]] || [[ $1 = "--help" ]] || [[ $1 = "-h" ]]; then
    echo "$SCRIPTNAME / $VERSION"
    echo "One argument is required:"
    showarguments
    exit 255
elif [[ $1 = "--version" ]] || [[ $1 = "-v" ]]; then
    echo "$SCRIPTNAME / $VERSION"
    exit 255
fi

if [[ $1 != "--start" ]] && [[ $1 != "--chroot" ]]; then
    echo "$SCRIPTNAME / $VERSION"
    echo "Wrong argument: please choose one argument among:"
    showarguments
    exit 255
fi

# ============================================================================
# ==== REAL STARTPOINT =======================================================
# ============================================================================

echo "========================================="
echo "=== $SCRIPTNAME / $VERSION ==="
echo "========================================="

TITLECOLOR='\033[0;33m'
DEFAULTCOLOR='\033[0m'

title () {
  echo
  echo -e "${TITLECOLOR}$1${DEFAULTCOLOR}"
  echo
  sleep 2
}

aftersection () {
    sleep 4
}

if [[ $1 = "--start" ]]; then
title "[A.01] === sfdisk /dev/sda < 1.sfdisk ==="
less
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
aftersection

title "[A.02] === format ==="
mkfs.ext4 -F /dev/sda2
mkswap /dev/sda1
aftersection

title "[A.03] === mount and swapon ==="
mount /dev/sda2 /mnt
swapon /dev/sda1
aftersection

title "[A.04] === pacstrap ==="

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
curl https://raw.githubusercontent.com/suizokukan/myarchlinux/main/louisix12261270/1.mirrorlist > 1.mirrorlist
cp 1.mirrorlist /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist

pacman -Syy

pacstrap /mnt base linux linux-firmware

aftersection

title "[A.05] === /mnt/etc/fstab ==="
genfstab -U /mnt >> /mnt/etc/fstab
aftersection

title "[A.06] === arch-chroot /mnt ==="
cp 1a.sh /mnt

echo "about to chroot on /mnt ..."
aftersection
arch-chroot /mnt sh 1a.sh --chroot

echo "POST CHROOT"
fi
