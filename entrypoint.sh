#!/bin/bash

SUPERVISOR_CONFIG_DIR="/etc/supervisor/conf.d"
SUPERVISOR_CUSTOM_CONFIG_DIR="/home/docker/code/config"
INIT_SCRIPT_DIR="/home/docker/code/custom"

if [ ! -d "$INIT_SCRIPT_DIR" ]; then
    mkdir $INIT_SCRIPT_DIR
fi

if [ ! -d "$SUPERVISOR_CUSTOM_CONFIG_DIR" ]; then
    mkdir $SUPERVISOR_CUSTOM_CONFIG_DIR
fi

for f in $INIT_SCRIPT_DIR/*; do
    case "$f" in
        *.sh)     echo "$0: running $f"; . "$f" ;;
        *.py)     echo "$0: running $f"; python "$f"; echo ;;
        *)        echo "$0: ignoring $f" ;;
    esac
    echo
done

if [ "`ls -A $SUPERVISOR_CONFIG_DIR`" = "" ]; then
    echo "$SUPERVISOR_CONFIG_DIR is indeed empty"
    cp /home/docker/code/supervisor-app.conf $SUPERVISOR_CONFIG_DIR
    cp $SUPERVISOR_CUSTOM_CONFIG_DIR/*.conf $SUPERVISOR_CONFIG_DIR
else
    echo "$SUPERVISOR_CONFIG_DIR is not empty"
    rm $SUPERVISOR_CONFIG_DIR/*.conf
    cp /home/docker/code/supervisor-app.conf $SUPERVISOR_CONFIG_DIR
    cp $SUPERVISOR_CUSTOM_CONFIG_DIR/*.conf $SUPERVISOR_CONFIG_DIR
fi

supervisord -n