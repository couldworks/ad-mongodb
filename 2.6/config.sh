#!/bin/bash

PASS=${MONGODB_PASS:-$(pwgen -s 20 1)}
LANDSAT_PASSWORD=${LANDSAT_PASSWORD:-$(pwgen -s 20 1)}
USERNAME=${USERNAME:-landsatuser}
_word=$( [ ${MONGODB_PASS} ] && echo "preset" || echo "random" )

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

echo "=> Creating an admin user with a ${_word} password in MongoDB"
mongo landsat-api --eval "username='$USERNAME';password='$LANDSAT_PASSWORD';databaseName='landsat-api';" /config.js
mongo admin --eval "db.createUser({user: 'admin', pwd: '$PASS', roles:[{role:'root',db:'admin'}]});"

echo "=> Done!"
touch /data/db/.mongo_configured

echo "========================================================================"
echo "You can now connect to this MongoDB server using:"
echo ""
echo "    mongo admin -u admin -p $PASS --host <host> --port <port>"
echo "    mongo landsat-api -u landsatuser -p $LANDSAT_PASSWORD --host <host> --port <port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
