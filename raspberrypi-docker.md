# Running Docker on Raspberry Pi

- This guide is valid for Raspian Buster. 
- most docker container images built on x86 will not mount on ARM CPUs - the containers in question must be re-built on ARM.

## Install

You can get Docker to install on Raspbian using the basic

    apt-get install docker-io docker-compose -y
    
but this install will not functional properly (container mounting fails with "unable to find "net_prio" in controller set"). The simplest install is

    curl -fsSL get.docker.com | CHANNEL=nightly sh

## Gotchas

### 1 - docker login

Logging in to docker fails with

    WARNING! Using --password via the CLI is insecure. Use --password-stdin.
    Error saving credentials: error storing credentials - err: exit status 1, out: `Cannot autolaunch D-Bus without X11 $DISPLAY`

The simplest work around at time of writing can be found  [here](https://github.com/docker/docker-credential-helpers/issues/105#issuecomment-420480401)

    sudo apt-get remove golang-docker-credential-helpers
    docker login
    <login as normal>
    sudo apt-get install docker-compose

