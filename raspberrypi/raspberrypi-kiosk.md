# Raspberry Pi Kiosk

This is a simple browser-driven kiosk for the Raspberry Pi. It boots into the Raspbian desktop, automatically starts the 
Chromium browser in full screen mode, and navigates to a given URL. This solution is confirmed working on Raspian Stretch only, and should be tweakable on other versions. This guide assumes you are already familiar with the basics of using a Rasperry Pi.

Burn the Raspian Stretch image to an SD card. In the root of your SD's card "boot" partition create an empty file called "ssh" (no extension), this will enable incoming ssh connections. Connect your Pi to your nework via ethernet, boot from the SD card, SSH to it @ host "raspberrypi". Start the config menu with
    
    sudo raspi-config    

and do the following :

- Change the password (or you will get an annoying desktop prompt to do so). 
- Under "boot options" set to boot to desktop with autologin as user "pi". 
- (optional : helps if you plan on having other Pi's on your network) Under "network" change hostname to something other than "raspberrypi". Save and reboot. Reconnect, update your package list with

    sudo apt-get update

Install unclutter and xdotool, these improve your desktop experience

    sudo apt-get install unclutter -y
    sudo apt-get install xdotool -y

Add remote desktop if you want to test kiosk functionality remotely

    sudo apt-get install xrdp -y

Note that your remote desktop is NOT the same instance displayed via your HDMI output. Edit the X server auto start script. If this script doesn't exist, you'll have to create the folder hierarchy to place it in

    sudo nano /home/pi/.config/lxsession/LXDE-pi/autostart

Delete any existing content (you might want to create a backup of your original script if there is one), and set its contents to look like

    @lxpanel --profile LXDE-pi
    @pcmanfm --desktop --profile LXDE-pi
    @unclutter -idle 0.1 -root
    @xset s noblank
    @xset s off
    @xset -dpms
    @point-rpi
    @chromium-browser --kiosk --incognito http://[YOUR-URL-HERE.com]

replace [YOUR-URL-HERE.com] with whatever you want to display. Finally reboot

    sudo reboot

After startup you should get a full screen Chromium instance displaying the url you added.

## Video mode

To display video instead of a webpage, install VLC

    sudo apt-get install vlc -y
 
 And replace the @chromium-browser line in your autostart script with a command to play a video file
 
     @vlc /path/to/video.mp4 --fullscreen --loop

Or better still, a playlist

    @vlc /path/to/video.xspf --fullscreen --loop

Note, you'll probbaly want to disable onscreen titles in VLC : 

    Tools > Preferences > Select Subtitles & OSD > Show media title on video start
    
    
