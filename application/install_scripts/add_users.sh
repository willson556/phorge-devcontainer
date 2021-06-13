#!/bin/bash

# Add users
echo "git:x:2000:2000:user for phorge ssh:/srv/phorge:/bin/bash" >> /etc/passwd
echo "phorge-daemon:x:2001:2000:user for phorge daemons:/srv/phorge:/bin/bash" >> /etc/passwd
echo "wwwgrp-phorge:!:2000:nginx" >> /etc/group

# Add repo directory
mkdir -p /var/repo/
chown phorge-daemon:2000 /var/repo/
mkdir -p /var/tmp/phd/pid
chmod 0777 /var/tmp/phd/pid

# Add git to sudoers
echo "git ALL=(phorge-daemon) SETENV: NOPASSWD: /usr/bin/git-upload-pack, /usr/bin/git-receive-pack" > /etc/sudoers.d/git