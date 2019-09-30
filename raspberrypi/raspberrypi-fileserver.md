# Raspbery Pi file server

This guide describes constructing a multi-disk file server basedon a Raspberry Pi 4. The server has relatively high throughput because of the Pi 4's improved disk IO.

## Hardware

- Raspberry Pi 4 (1,2 or 4GB model)
- [TP-Link UH700](https://www.tp-link.com/us/home-networking/usb-hub/uh700/) powered USB3.0 hub
- 1-6 [4tb Seagate Backup Plus](https://www.seagate.com/gb/en/consumer/backup/backup-plus/). You can use any unpowered USB 3.0 drive, but I find these Seagate drives to be perfect for their large size and low price.
- USB A-to-C power cable for the Raspberry Pi. 

You won't need a dedicated power supply for the Pi - connect its power input to one of the ports on the hub. As long as you aren't connecting any power-drawing devices to the Pi's USB ports, the hub will provide enough power without undervolting.

## Software

- For a base OS I used Raspbian Buster lite, with SSH enabled.
- I opted for NTFS as the drive's file system. This makes it easy to transfer the disks to other machines, as NTFS is fairly widely supported now. 
- For file sharing I used Samba.

## Setup

This guide assumes you're already comfortable installing Rasbian on an SSD and accessing it via SSH.

- [Setting up Samba](raspberrypi-samba-server.md)
- [Enabling drive spin-down](raspberrypi-drivespindown.md)

## Power Draw

- The base power draw of a Raspberry PI 4 idling is 6 watts.
- The base power draw of the TP-Link hub with no devices attached is 4W.
- The draw of the Pi, TP-Link and 2 4TB Seagate disks, with the disks powered down, is 11W, and I'm assuming this draw will remain flat for additional drives when powered down.

Draw was measured using an ESIC PM300 meter, but any metering unit will do.

## Future improvements

- Migrate disks to a more resilient file system like Btrfs.
- Build a compact, well-ventilated case for the hub and disks.



