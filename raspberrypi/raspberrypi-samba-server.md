# Samba server on Raspberry Pi

Requires a Rarpberry Pi 3b or better. Confirmed working on Stretch and Buster. This guide is for NTFS disks - disks should already be formatted for NTFS. If they are not, I 
strongly suggest you mount and format them on a Windows system, as this seems to be the fastest solution.

    sudo apt-get update 
    sudo apt-get upgrade -y

Then run this agains to update the list after upgrade
  
    sudo apt-get update 

Install ntfs support. reboot is necessary for ntfs support to be applied (if you get modprobe: FATAL: Module fuse not found)

    sudo apt-get install ntfs-3g -y
    sudo reboot

You should should now be able to see your usb device as /dev/sda1 or /dev/sda2

    sudo blkid

You will also be able to read it's UUID="some-random-string"

Assuming */dev/sdaX* is your drive and */mnt/extStorage* is where you want to mount it, test mount the drive 

    sudo mkdir /mnt/extStorage
    sudo mount -t ntfs-3g /dev/sdaX /mnt/extStorage

confirm the mount with

    ls /mnt/extStorage/

then unmount again with

    umount /mnt/extStorage

Now make the mount permanent

    sudo nano /etc/fstab

and add this line to end of file, dont' forget to change the X to your dev number

    UUID=some-random-string /mnt/extStorage ntfs-3g defaults,nofail 0 0

Substituting in the UUID of your drive (without quotes). Avoid mounting /dev/xxx references, as these can  suddenly change when you add new drives to your system. The "nofail" option allows your Pi to continue booting if the drive mount should fail - not setting this will likely cause you to get locked out of your Pi.

Restart and confirm everything works

    sudo reboot

install samba (note, this can give a prompt requiring input)

    sudo apt-get install samba samba-common-bin -y

Edit your samba conf file

    sudo nano /etc/samba/smb.conf

if your version of Samba lists win support (near the top of file), enable it. Newer versions have dropped this.
    
    win support = yes

workgroup should match your pc's workgroup, the default value should be fine

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


For a private share, from shell, create a unix user and give that user a samba password, this can be the same as its unix password
    
    sudo adduser YOURUSERNAME
    sudo smbpasswd -a YOURUSERNAME

edit samba.conf above, add the following line to your share setup
    
    [shared]
        ...
        valid users = YOURUSERNAME
        ...
    
restart samba

    sudo service smbd restart
