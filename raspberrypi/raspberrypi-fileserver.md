# Raspbery Pi file server

This guide describes constructing a simple, multi-disk file server basedon a Raspberry Pi 4. The server has relatively high throughput because of the Pi 4's improved disk IO. Note that this server is only for storing and sharing your files on a local network - it doesn't have anything fancy like RAID for increased speed or data redundancy.

## Hardware

- Raspberry Pi 4 (1,2 or 4GB model)
- [TP-Link UH700](https://www.tp-link.com/us/home-networking/usb-hub/uh700/) powered USB3.0 hub
- 1-6 [4tb Seagate Backup Plus](https://www.seagate.com/gb/en/consumer/backup/backup-plus/). You can use any unpowered USB 3.0 drive, but I find these Seagate drives to be perfect for their large size and low price.
- USB A-to-C power cable for the Raspberry Pi. 

You won't need a dedicated power supply for the Pi - connect its power input to one of the ports on the hub. As long as you aren't connecting any power-drawing devices to the Pi's USB ports, the hub will provide enough power without undervolting.

## Software

- For a base OS I used Raspbian Buster lite, with SSH enabled.
- I opted for NTFS as the drive's file system. This makes it easy to transfer the disks to other machines, including Windows.  
- For file sharing I used Samba.

## Setup

This guide assumes you're already comfortable installing Rasbian on an SSD and accessing it via SSH.

- [Setting up Samba](raspberrypi-samba-server.md)
- [Enabling drive spin-down](raspberrypi-drivespindown.md)

## Power Draw

- The base power draw of a Raspberry PI 4 idling is 6 watts.
- The base power draw of the TP-Link hub with no devices attached is 4W.
- The draw of the Pi, TP-Link and 2 4TB Seagate disks, with the disks powered down, is 11W, and I'm assuming this draw will remain flat for additional drives when powered down.

Draw was measured using an ESIC PM300 meter.

## Really simply redundancy

I wanted to add some kind of data safety to this system. Ideally it would be Raid 1, but I cannot find an implementation that works over USB, so here's a poor-man's compromise - duplicate the data from one drive onto another with a cronjob and rsync. Edit your cron jobs with 

    crontab -e

and to the bottom add

    0 0 * * 0 rsync -avh /mnt/drive1/ /mnt/drive2/ --delete > /home/pi/rsync-cron.log 2>&1

`0 0 * * 0` syncs my data every Sunday, from `/mnt/drive1/` to `/mnt/drive2/`. The result of this are logged to `~/rsync-cron.log` just so you have some idea of what's going on. Change the cronmask, source, target folders and log path to whatever suits you. 

If you want to take it a step a further, I wrote a backup script that has a bit more safety 
- it won't backup an empty source disk to a populated backup disk, this can happen if your source drive fails to mount
- it will email you if a failure happens.

The script is [here](https://github.com/shukriadams/guides/blob/master/raspberrypi/backup.sh), place it at `/home/pi/backup.sh`, update it to include the paths you want backed up and in crontab use this instead

    0 0 * * 0 /home/pi/backup.sh /home/pi/backup-cron.log 2>&1

## Future improvements

- Build a compact, well-ventilated case for the hub and disks.



