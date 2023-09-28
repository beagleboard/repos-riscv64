#!/bin/bash
echo "================================================================================"
echo "|                            FPGA Gateware Update                              |"
echo "|                                                                              |"
echo "|   Please ensure that the mpfs_bitstream.spi file containing the gateware     |"
echo "|   update has been copied to directory /lib/firmware.                         |"
echo "|                                                                              |"
echo "|                 !!! This will take a couple of minutes. !!!                  |"
echo "|                                                                              |"
echo "|               Give the system a few minutes to reboot itself                 |"
echo "|                        after Linux has shutdown.                             |"
echo "|                                                                              |"
echo "================================================================================"

if [ ! -f /lib/firmware/mpfs_bitstream.spi ] ; then
	echo "Missing: /lib/firmware/mpfs_bitstream.spi"
	exit 2
fi

#read -rsp $'Press any key to continue...\n' -n1 key

if [ ! -f /sys/kernel/debug/fpga/microchip_exec_update ] ; then
	/usr/bin/mount -t debugfs none /sys/kernel/debug
fi

# Trash exisitng device tree overlay in case the rest of the process fails:
/usr/sbin/mtd_debug erase /dev/mtd0 0x0 0x10000

# Write device tree overlay
dtbo_ls=$(ls -l /lib/firmware/mpfs_dtbo.spi)
dtbo_size=$(echo $dtbo_ls | cut -d " "  -f 5)

echo "Writing mpfs_dtbo.spi to /dev/mtd0"
/usr/sbin/mtd_debug write /dev/mtd0 0x400 $dtbo_size /lib/firmware/mpfs_dtbo.spi > /dev/zero

# Fake the presence of a golden image for now.
/usr/sbin/mtd_debug write /dev/mtd0 0 4 /dev/zero > /dev/zero

# Initiate FPGA update.
echo "Triggering FPGA Gateware Update (/sys/kernel/debug/fpga/microchip_exec_update)"
echo 1 > /sys/kernel/debug/fpga/microchip_exec_update

# Reboot Linux for the gateware update to take effect.
# FPGA reprogramming takes places between Linux shut-down and HSS restarting the board.
/usr/sbin/reboot
