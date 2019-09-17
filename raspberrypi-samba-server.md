# Samba server on Raspberry Pi

- Requires a Rarpberry Pi 3b or better.
- confirmed working on Stretch and Buster.

    sudo apt-get update 
    sudo apt-get upgrade -y

Then run this agains to update the list after upgrade
  
    sudo apt-get update 

Install ntfs support. reboot is necessary for ntfs support to be applied (if you get modprobe: FATAL: Module fuse not found)

    sudo apt-get install ntfs-3g -y
    sudo reboot

You should should now be able to see your usb device as /dev/sda1 or /dev/sda2

    sudo blkid

Assiming */dev/sdaX* is your drive and */mnt/extStorage* is where you want to mount it

mount drive where X is the number from blkid above

    sudo mkdir /mnt/extStorage
    sudo mount -t ntfs-3g /dev/sdaX /mnt/extStorage

confirm the mount 

    ls /mnt/extStorage/

(hint, to unmount)

    umount /mnt/extStorage

Make the mount permanent

    sudo nano /etc/fstab

and add this line to end of file, dont' forget to change the X to your dev number

    /dev/sdaX /mnt/extStorage ntfs-3g defaults 0 0

restart and confirm everything works

    sudo reboot

install samba (note, this can give a prompt requiring input)

    sudo apt-get install samba samba-common-bin -y

Edit your samba conf file

    sudo nano /etc/samba/smb.conf

if you version of Samba has this (near the top of file) enable it and change to the following. newer versions dropped this.
    
    win support = yes

workgroup should match your pc's workgroup, default value should be fine

    workgroup = your_workgroup_name # WORKGROUP is default can normally leave this as is

To end of file add the following

- [myShare] means your your SMB share will appear as myShare under your host name. This can be any string you want.
- Note: this creates a fully public share

    [myShare]
       comment=some comment #  not important   
    path=/mnt/extStorage
       browseable=Yes
       writeable=Yes
       only guest=no
       create mask=0777
       directory mask=0777
       public=yes

restart samba
    
    sudo service smbd restart

Your samba share should now be available at \\PIHOSTNAME or smb:\\PIHOSTNAME


For a private share, from shell, create a unix user and give that user a samba password, this can be the same as itsunix password
    
    sudo adduser YOURUSERNAME
    sudo smbpasswd -a YOURUSERNAME

edit samba.conf above, add the following line to your share setup
    
    [shared]
        ...
        valid users = YOURUSERNAME
        ...
    
restart samba

    sudo service smbd restart
