# Private VPN

your vps should have 1 core, 512 megs of ram, and plenty of bandwidth
install ubuntu 18.04

ssh into box

create a non-root user, give it root permission log to this user

update and upgrade

    sudo apt-get update -y
    sudo apt upgrade -y

## enable auto security updates

install app

    sudo apt install unattended-upgrades -y

edit security settings

    sudo nano /etc/apt/apt.conf.d/50unattended-upgrades

find the line "${distro_id}:${distro_codename}-updates"; in the first Uanttended-Upgrade:: block and remove its leading \\ to enable it.
  
find, uncomment and set the following lines based on requirements
    
    Unattended-Upgrade::Mail "user@example.com";
    Unattended-Upgrade::MailOnlyOnError "true";
    Unattended-Upgrade::Remove-Unused-Dependencies "true";
    Unattended-Upgrade::Automatic-Reboot "true";
    Unattended-Upgrade::Automatic-Reboot-Time "02:38";
  
Enable updates  

    sudo nano /etc/apt/apt.conf.d/20auto-upgrades
  
copy these lines into file

    APT::Periodic::Update-Package-Lists "1";
    APT::Periodic::Download-Upgradeable-Packages "1";
    APT::Periodic::AutocleanInterval "7";
    APT::Periodic::Unattended-Upgrade "1";

test that auto updates are working by doing a dry run

    sudo unattended-upgrades --dry-run --debug

you can also confirm auto updates have run by checking logs after a few days

    cat /var/log/unattended-upgrades/unattended-upgrades.log

## Firewall

    sudo ufw status

    sudo ufw allow ssh (Must do this before enabling or you can't ssh in!)
    sudo ufw allow http
    sudo ufw allow https
    sudo ufw allow 10447/udp
    sudo ufw enable

Note we opened port 10447 UDP above, this will be our server's public port, we could have used another port though. 

After changes restart ufw with
 
    sudo ufw reload 

## Pritunl

Add pritunl

    echo "deb http://repo.pritunl.com/stable/apt bionic main" | sudo tee /etc/apt/sources.list.d/pritunl.list

Add mongodb

    sudo nano /etc/apt/sources.list.d/mongodb-org-4.0.list

Paste this line into file

    deb https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse

Add public keys for repos

    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
    sudo apt update

Install Pritunl and Mongodb services

    sudo apt --assume-yes install pritunl mongodb-server
    sudo systemctl start pritunl mongodb
    sudo systemctl enable pritunl mongodb

Pritunl is now set up and ready to use - after this is most setup is done via the browser.

## Config

Navigate to your vps's ip number in a browser (port 80). You will be auto-bounced to https and get a warning from your browser as Pritunl is using a self-signed certificate. You should see a pritunl database setup prompt. From the command line still run

    sudo pritunl setup-key

this returns a key, paste the key into the pritunl prompt (leave mongo as is). Let pritunl do its thing, it should auto-reload and show you a new prompt asking for username and password. From the command line again run

    sudo pritunl default-password

and paste in the default username and password it gives you.

## management

create on organization and then a user

create a server, set its port to 10447 (the port we opened further up). Enable multidevices, google authenticator, etc.

Attach organization to server. Then click on "start server".

    
