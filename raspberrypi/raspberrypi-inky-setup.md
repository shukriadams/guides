# Raspberry Pi Inky Setup

- install Buster lite (latest version)
- write ssh to boot partition, and ssh in
- switch python to version 3 

      python --version
      
    should return "2.7" or similar, which is still the default on Raspbian. Confirm you have 3.7 installed on your system (at the time of writing Buster shipped with Python3.7
    
      whereis python 
       
    which should show a list that includes '/usr/bin/python3.7'. Update your bash settings 
    
      nano ~/.bashrc
        
    Add the following line at the end of the file and relog for changes to take effect
    
      alias python='/usr/bin/python3.7'

- install inky and prerequisites with

      sudo curl https://get.pimoroni.com/inky | bash

    This script will install a bunch of things and can run really slow on older Pi's - it's highly recommended you do this on a more modern unit. The script will also prompt you for input several times so don't leave it attended. After installing you might want to image your SD card so you don't have to go through this again.
    
- confirm your Inky works (assuming you're running a red wHat)

      cd ~/Pimoroni/inky/examples 
      python logo.py -t what -c red
      
