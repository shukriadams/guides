# Enabling harddrive spin-down on Raspberry Pi

USB 3.0 drives connected to the Raspberry Pi can be set to spin down while not in use.

Install hd-idle by building it. First install required build tools

    sudo apt-get install build-essential fakeroot debhelper -y

Download source

    wget http://sourceforge.net/projects/hd-idle/files/hd-idle-1.05.tgz
    
Unzip

    tar -xvf hd-idle-1.05.tgz
    cd hd-idle

Build 

    dpkg-buildpackage -rfakeroot

It will likely exit with error "dpkg-buildpackage: error: failed to sign .dsc file" but this doesn't mean the build failed.

Install

    sudo dpkg -i ../hd-idle_*.deb
    
Confirm it works with

    sudo hd-idle -i 0 -a sda -i 300 -d
    
this should return probe results from the given device
Edit hd-idle's config

    sudo nano /etc/default/hd-idle
    
close to the top of the file, find and set the following flag to enable it

    START_HD_IDLE=true
    
At the end of the file, add the following line to set all drives to sleep after 10 minutes(600 seconds)

    HD_IDLE_OPTS="-i 0 -i 600"

Restart service for changes to take effect

    sudo service hd-idle restart

(credits : https://www.htpcguides.com/spin-down-and-manage-hard-drive-power-on-raspberry-pi/)
    
