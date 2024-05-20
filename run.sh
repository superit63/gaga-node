#!/bin/bash

# ASCII art
echo '
   ____          ____         _   _             _
  / ___|  __ _  / ___|  __ _ | \ | |  ___    __| |  ___
 | |  _  / _` || |  _  / _` ||  \| | / _ \  / _` | / _ \
 | |_| || (_| || |_| || (_| || |\  || (_) || (_| ||  __/
  \____| \__,_| \____| \__,_||_| \_| \___/  \__,_| \___|
'

# Check if apphub-linux directory exists
if [ -d ./apphub-linux* ]; then
    cd ./apphub-linux* || exit 1

    # Start apphub service
    sudo ./apphub service start
    sleep 60

    # Show apphub status and log
    sudo ./apphub status
    sudo ./apphub log
    sudo ./apps/gaganode/gaganode log

    # Print token
    echo
    echo "Token: $TOKEN"
else
    CPU_ARCH=$(uname -m)

    case "$CPU_ARCH" in
        x86_64)
            FILENAME="gaganode_pro-0_0_300.tar.gz"
            TYPE=66
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

    LINK="https://assets.coreservice.io/public/package/66/gaganode_pro/0.0.300/gaganode_pro-0_0_300.tar.gz"

    echo "CPU Arch: $CPU_ARCH"
    echo "Download link: $LINK"
    echo "Binary: $FILENAME"
    echo
    echo "Downloading binary..."

    # Download binary
    if ! sudo curl -o "$FILENAME" "$LINK"; then
        echo "Error: Failed to download binary."
        exit 1
    fi

    # Extract binary
    if ! sudo tar -zxf "$FILENAME"; then
        echo "Error: Failed to extract binary."
        exit 1
    fi

    # Remove downloaded tar.gz file
    sudo rm -f "$FILENAME"

    cd ./apphub-linux* || exit 1

    # Remove existing apphub service
    sudo ./apphub service remove

    # Install apphub service
    sudo ./apphub service install

    # Start apphub service
    sudo ./apphub service start

    echo
    echo "Bootstrapping 30s timeout..."
    sleep 30

    # Show apphub status
    sudo ./apphub status

    # Set token for gaganode
    sudo ./apps/gaganode/gaganode config set --token="$TOKEN"

    # Restart apphub service
    sudo ./apphub restart
    sleep 15

    # Show apphub status and log
    sudo ./apphub status
    sudo ./apphub log
    sudo ./apps/gaganode/gaganode log

    # Print token
    echo
    echo "Token: $TOKEN"
fi
