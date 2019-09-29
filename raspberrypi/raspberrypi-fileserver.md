# Raspbery Pi file server

This guide describes constructing a multi-disk file server basedon a Raspberry Pi 4. The server has relatively high throughput because of the Pi 4's imrpoved disk IO.

## Hardware

- Raspberry Pi 4 (1,2 or 4GB model)
- (https://www.tp-link.com/us/home-networking/usb-hub/uh700/)[TP-Link UH700] powered USB3.0 hub
- 1-6 (https://www.seagate.com/gb/en/consumer/backup/backup-plus/)[4tb Seagate Backup Plus]. You can use any unpowered USB 3.0 drive, but I find these Seagate drives to be perfect for their large size and low price.
- USB A-to-C power cable for the Raspberry Pi.

## Software

- For a base OS we'll use Raspbian Buster lite, with SSH enabled.
- For file sharing we'll use Samba.
- For file system we'll use NTFS. This makes it easy to transfer the disks to other machines, as NTFS is fairly widely supported now.

## Setup

This guide assumes you're already comfortable installing Rasbian on an SSD and accessing it via SSH.

- (raspberrypi-samba-server.md)[Setting up Samba]
- (raspberrypi-drivespindown.md)[Enabling drive spin-down]

## Power Draw

- The base power draw of a Raspberry PI 4 idling is 6 watts.
- The base power draw of the TP-Link hub with no devices plugged into it is 4W.
- The draw of the Pi, TP-Link and 2 4TB Seagate disks, with the disks powered down, was 11W, and I'm assuming this draw will remain flat if additional drives are attached.

Draw was measured using an ESIC PM300 meter, but any metering unit will do.



