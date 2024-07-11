#!/bin/bash

if ! id | grep -q root; then
	echo "must be run as root"
	exit
fi

if [ -d $1 ]
then
    echo "Changing gateware."
    if [ -e $1/LinuxProgramming/mpfs_bitstream.spi ]
    then
        if [ -e $1/LinuxProgramming/mpfs_dtbo.spi ]
        then
            flash_erase /dev/mtd0 0 16
            dtbo_size=$(stat -c %s $1/LinuxProgramming/mpfs_dtbo.spi)
            nandwrite --start=0x400 /dev/mtd0 $1/LinuxProgramming/mpfs_dtbo.spi
            echo 1 > /sys/class/firmware/mpfs-auto-update/loading
            cat $1/LinuxProgramming/mpfs_bitstream.spi > /sys/class/firmware/mpfs-auto-update/data
            sync
            echo 0 > /sys/class/firmware/mpfs-auto-update/loading
            systemctl reboot
        else
            echo "No device tree overlay file found."
        fi
    else
        echo "No gateware file found."
    fi
else
    echo "No directory found for this requested gateware."
fi
