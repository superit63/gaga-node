#!/bin/bash

echo '
   ____          ____         _   _             _
  / ___|  __ _  / ___|  __ _ | \ | |  ___    __| |  ___
 | |  _  / _` || |  _  / _` ||  \| | / _ \  / _` | / _ \
 | |_| || (_| || |_| || (_| || |\  || (_) || (_| ||  __/
  \____| \__,_| \____| \__,_||_| \_| \___/  \__,_| \___|
'

# Tìm thư mục chứa apphub-linux
apphub_dir=$(find . -type d -name "apphub-linux*" -print -quit)

if [[ -n "$apphub_dir" ]]; then
    cd "$apphub_dir" || exit 1

    sudo ./apphub service start
    sleep 60
    sudo ./apphub status
    sudo ./apphub log
    sudo ./apps/gaganode/gaganode log
    echo
    echo "Token: $TOKEN"
else
    CPU_ARCH=$(uname -m)

    case "$CPU_ARCH" in
        x86_64)
            FILENAME="app-linux-amd64.tar.gz"
            TYPE=60
            ;;
        arm64|aarch64)
            FILENAME="app-linux-arm64.tar.gz"
            TYPE=61
            ;;
        i386)
            FILENAME="app-linux-386.tar.gz"
            TYPE=70
            ;;
        armv8l|armv7l|armv6l)
            FILENAME="app-linux-arm32.tar.gz"
            TYPE=72
            ;;
        *)
            echo "Your CPU type is not supported."
            exit 1
            ;;
    esac

    LINK="https://assets.coreservice.io/public/package/$TYPE/app-market-gaga-pro/1.0.4/app-market-gaga-pro-1_0_4.tar.gz"

    echo "CPU Arch: $CPU_ARCH"
    echo "Download link: $LINK"
    echo "Binary: $FILENAME"
    echo
    echo "Downloading binary..."

    sudo curl -o "$FILENAME" "$LINK"
    sudo tar -zxf "$FILENAME"
    sudo rm -f "$FILENAME"

    # Tìm thư mục chứa apphub-linux một lần nữa sau khi giải nén
    apphub_dir=$(find . -type d -name "apphub-linux*" -print -quit)
    if [[ -z "$apphub_dir" ]]; then
        echo "Error: Unable to locate apphub-linux directory after extraction."
        exit 1
    fi

    cd "$apphub_dir" || exit 1

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
