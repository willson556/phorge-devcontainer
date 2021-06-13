
#!/bin/bash

set -e
set -x

pushd /srv/phorge/phorge

./bin/config set mysql.host $SQL_HOST
./bin/config set mysql.port $SQL_PORT
./bin/config set mysql.user $SQL_USER
./bin/config set mysql.pass $SQL_PASSWORD

./bin/config set phabricator.base-uri $BASE_URI

./bin/config set phd.user phorge-daemon
./bin/config set diffusion.ssh-user git

popd

pushd /srv/phorge/phorge

if [ -e /user-config/authorized_keys ]; then
    echo "Copying authorized_keys file into place"
    mkdir -p /root/.ssh/
    cp /user-config/authorized_keys /root/.ssh/
    chmod 600 /root/.ssh/authorized_keys
fi

if [ -e /user-config/script.post ]; then
    echo "Applying post-configuration script..."
    /config/script.post
fi

if [ -e /user-config/cert.pem ]; then
    if [ -e /user-config/cert.key ]; then
        echo "Enabling SSL due to presence of certificates!"
        cp /etc/nginx/nginx-ssl.conf.org /etc/nginx/nginx.conf
    fi
else
    cp /etc/nginx/nginx.conf.org /etc/nginx/nginx.conf
fi

popd

/srv/phorge/phorge/bin/storage upgrade --force
