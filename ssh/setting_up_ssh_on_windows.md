# How to set up SSH on Windows


## Install SSH first

First, ensure you have SSH available from a vanilla command line - Windows Key + R to open `Run` dialog, then enter `cmd`, then run `ssh`, you should get a bunch of help output.

If SSH is not working from the command line, I STRONGLY suggest you use the ssh client in git. Install [git-for-windows](https://git-scm.com/download/win), add `<install-path>/git/usr/bin` to your Windows PATH environment variable, then in a new cmd window ensure that ssh is available.


## Create an SSH Key

You should have an ssh folder at the location `c:/users/<YOU>/.ssh`, if this folder doesn't exist, create it manually. If the folder exists, check if it has the files `id_rsa` and `id_rsa.pub` in it -  these are your private and public key files respectively. If they don't exist, create them as follows. 

At the command line run

    ssh-keygen -t rsa -b 4096 -C "<YOUR EMAIL HERE>"

- Accept the default location `(C:\Users\<YOU>/.ssh/id_rsa)`. If you see a different path, escape and check the "Map user folder" section below, then restart key creation.

- Select empty passphrase for your key.


## Bind your SSH Key to Github

Assume you want to use your key on Github. 

- Open the public key file `c:/users/<YOU>/.ssh/id_rsa.pub` in a text editor, select the contents and copy.

- In github.com, go to profile key settings at [https://github.com/settings/keys](https://github.com/settings/keys)

- Click on "New SSH key", give it any title you want (typically your PC name as keys should be PC specific), and then paste the public key text into "key". Save.


## Test your key

On your PC, open a command window and run

    ssh -T git@github.com

You should get the reply `Hi <YOU>! You've successfully authenticated, but GitHub does not provide shell access.` This means your SSH session is working. 

You can add your public key to other sites like Bitbucket too, the process for most sites is similar, though the test will differ 

    ssh -T git@bitbucket.org

Search the interwubs for info on adding and testing access on the site in question.


## Map user folder 

Very rarely, you will need to map your home directory first. Add the `HOME` environment variable in Windows and explicitly set it to your user directory path `c:/users/<YOU>`, then reboot windows


## What about Putty? What about <some-ssh-client-x> ? 

Sorry, can't help. Use the system above, it just works.




