FROM ubuntu:20.04

# == Copy Data ==
COPY install_scripts /install_scripts

# == Configure Ubuntu ==
WORKDIR /install_scripts
RUN sh install_dependencies.sh
RUN sh add_users.sh

# == Set up the Phorge code base ==
RUN mkdir /srv/phorge
RUN chown git:wwwgrp-phorge /srv/phorge
USER git
WORKDIR /srv/phorge
RUN git clone https://we.phorge.it/source/phorge.git
RUN git clone https://we.phorge.it/source/arcanist.git
USER root
WORKDIR /
RUN mkdir -p /var/tmp/phd/log
RUN chown phorge-daemon:2000 /var/tmp/phd/log

# == Expose Ports ==

# Nginx
EXPOSE 80
# Aphlict
EXPOSE 22280
# SSH
EXPOSE 2222

# == Add service config files ==
ADD /config/nginx.conf.org /etc/nginx/
ADD /config/fastcgi.conf /etc/nginx/
ADD /config/php-fpm.conf /etc/php/7.4/fpm/
ADD /config/php.ini /etc/php/7.4/fpm/
ADD /config/aphlict.phorge.json /install_scripts/

# == Add Supervisord config files ==
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /etc/supervisor/conf.d/

ADD config/supervisord.conf /etc/supervisor/
COPY config/*.sv.conf /etc/supervisor/conf.d/

# == Configure Phorge SSH service ==
RUN mkdir /etc/phorge-ssh
RUN mkdir /var/run/sshd/
RUN chmod 0755 /var/run/sshd
ADD config/sshd_config.phorge /etc/phorge-ssh/
ADD config/phorge-ssh-hook.sh /etc/phorge-ssh/
RUN chown root:root /etc/phorge-ssh/*

# == Copy other scripts == #
COPY user-config /user-config
COPY startup.sh /

CMD bash ./startup.sh && supervisord
