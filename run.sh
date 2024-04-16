#!/bin/bash

CPU_ARCH=$(uname -m)
LINK="https://assets.coreservice.io/public/package/60/app-market-gaga-pro/1.0.4/app-market-gaga-pro-1_0_4.tar.gz"
echo "CPU Arch: $CPU_ARCH"
echo "Download link: $LINK"
echo

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

if [ -d ./apphub-linux* ]; then
	echo "apphub-linux found."
	echo
	cd ./apphub-linux* || exit 1

	sudo ./apphub service start
	sudo ./apphub status
	sudo ./apphub log
	sudo ./apps/gaganode/gaganode log
	cat ./apps/gaganode/user_conf/default.toml
else
	echo "apphub-linux NOT found.\n"
	sudo curl -o $FILENAME $LINK
	sudo tar -zxf $FILENAME
	sudo rm -f $FILENAME
	cd ./apphub-linux* || exit 1

	sudo ./apphub service remove
	sudo ./apphub service install
	sudo ./apphub service start
	sudo ./apphub status

	sleep 30
	echo '
	 ____   ___  _   _ _____
	|  _ \ / _ \| \ | | ____|
	| | | | | | |  \| |  _|
	| |_| | |_| | |\  | |___
	|____/ \___/|_| \_|_____|
	'
	sudo ./apphub status
	sudo ./apps/gaganode/gaganode config set --token="$TOKEN"
	sudo ./apphub restart
	sudo ./apps/gaganode/gaganode log
fi

/bin/bash
