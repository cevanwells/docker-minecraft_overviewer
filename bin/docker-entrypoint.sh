#!/bin/sh
set -e

if [ ! -z "${APP_DIR}/jars/client-${MC_VERSION}.jar" ]; then
    wget https://overviewer.org/textures/$MC_VERSION -O $APP_DIR/jars/client-$MC_VERSION.jar
fi

exec "$0"