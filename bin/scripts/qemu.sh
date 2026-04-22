#!/usr/bin/env bash

# requirements
# yay -Sy edk2-ovmf

# create disk
# qemu-img create -f qcow2 artix_disk.qcow2 30G

# mount vdisk on host
# sudo modprobe nbd max_part=2
# qemu-nbd --connect=/dev/nbd0 /path/to/your/image.qcow2
# sudo mount /dev/nbd0p1 /mnt/gentoo
#
# qemu-nbd --disconnect /dev/nbd0

ISO=artix-base-openrc-20250407-x86_64.iso
VDISK=artix_disk.qcow2
OVMF_CODE_FILE=/usr/share/OVMF/x64/OVMF_CODE.4m.fd
OVMF_VARS_FILE=ovmf_vars.fd

if [ ! -f $VDISK ]; then
    qemu-img create -f qcow2 $VDISK 30G
fi

if [ ! -f $OVMF_VARS_FILE ]; then
    cp /usr/share/OVMF/x64/OVMF_VARS.4m.fd $OVMF_VARS_FILE
fi

qemu-system-x86_64 -boot d \
          -enable-kvm \
          -m 4G \
          -cdrom $ISO \
          -netdev user,id=net0,hostfwd=tcp::2222-:22 \
          -device e1000,netdev=net0 \
          -drive file=$VDISK,format=qcow2 \
          -smp 6 \
          -display default,show-cursor=on \
          -drive if=pflash,format=raw,readonly=on,file=$OVMF_CODE_FILE \
          -drive if=pflash,format=raw,file=$OVMF_VARS_FILE

