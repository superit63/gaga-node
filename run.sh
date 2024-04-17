#!/bin/bash

echo '
   ____          ____         _   _             _
  / ___|  __ _  / ___|  __ _ | \ | |  ___    __| |  ___
 | |  _  / _` || |  _  / _` ||  \| | / _ \  / _` | / _ \
 | |_| || (_| || |_| || (_| || |\  || (_) || (_| ||  __/
  \____| \__,_| \____| \__,_||_| \_| \___/  \__,_| \___|
'

if [ -d ./apphub-linux* ]; then
    cd ./apphub-linux* || exit 1

    sudo ./apphub service start
    sleep 15
    sudo ./apphub status
    sudo ./apphub log
    sudo ./apps/gaganode/gaganode log
    echo
    echo "Token: $TOKEN"
else
    CPU_ARCH=$(uname -m)
    LINK="https://assets.coreservice.io/public/package/60/app-market-gaga-pro/1.0.4/app-market-gaga-pro-1_0_4.tar.gz"

    case "$CPU_ARCH" in
        x86_64)
            FILENAME="app-linux-amd64.tar.gz"
            ;;
        arm64|aarch64)
            FILENAME="app-linux-arm64.tar.gz"
            ;;
        i386)
            FILENAME="app-linux-386.tar.gz"
            ;;
        armv8l|armv7l|armv6l)
            FILENAME="app-linux-arm32.tar.gz"
            ;;
        *)
            echo "Your CPU type is not supported."
            exit 1
            ;;
    esac

    echo "CPU Arch: $CPU_ARCH"
    echo "Download link: $LINK"
    echo "Binary: $FILENAME"
    echo
    echo "Downloading binary..."

    sudo curl -o $FILENAME $LINK
    sudo tar -zxf $FILENAME
    sudo rm -f $FILENAME
    cd ./apphub-linux* || exit 1

    sudo ./apphub service remove
    sudo ./apphub service install
    sudo ./apphub service start

    echo
    echo "Bootstrapping 30s timeout..."
    sleep 30

    sudo ./apphub status
    sudo ./apps/gaganode/gaganode config set --token="$TOKEN"
    sudo ./apphub restart
    sleep 15
    sudo ./apphub status
    sudo ./apphub log
    sudo ./apps/gaganode/gaganode log
    echo
    echo "Token: $TOKEN"
fi
