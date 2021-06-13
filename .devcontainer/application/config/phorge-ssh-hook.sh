#!/bin/sh

# NOTE: Replace this with the username that you expect users to connect with.
VCSUSER="git"

ROOT="/srv/phorge/phorge"

if [ "$1" != "$VCSUSER" ];
then
  exit 1
fi

exec "$ROOT/bin/ssh-auth" $@
