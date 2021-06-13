
#!/bin/bash

set -x

echo "Waiting for mysql"
until mysql -h"$SQL_HOST" -P"$SQL_PORT" -u"$SQL_USER" -p"$SQL_PASSWORD" &> /dev/null
do
  printf "."
  sleep 1
done

echo -e "\nmysql ready"

pushd /srv/phorge/phorge

./bin/config set mysql.host $SQL_HOST
./bin/config set mysql.port $SQL_PORT
./bin/config set mysql.user $SQL_USER
./bin/config set mysql.pass $SQL_PASSWORD

./bin/config set phabricator.base-uri $BASE_URI

./bin/config set phd.user phorge-daemon
./bin/config set diffusion.ssh-user git
./bin/config set diffusion.ssh-port 2222
./bin/config set diffusion.allow-http-auth true

./bin/config set phabricator.developer-mode true
./bin/config set phabricator.show-prototypes true
./bin/config set darkconsole.enabled true

./bin/config set storage.mysql-engine.max-size 268435456
./bin/config set pygments.enabled true

./bin/config set environment.append-paths '["/usr/lib/git-core"]'

./bin/config set notification.servers --stdin < /install_scripts/aphlict.phorge.json

if [ -e /user-config/script.post ]; then
    echo "Applying post-configuration script..."
    /user-config/script.post
fi

popd

pushd /srv/phorge/phorge/support/aphlict/server

npm install ws

popd

cp /etc/nginx/nginx.conf.org /etc/nginx/nginx.conf
/srv/phorge/phorge/bin/storage upgrade --force
