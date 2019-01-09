#!/bin/bash
# Set them to empty is NOT SECURE but avoid them display in random logs.
export VNC_PASSWD=''
export USER_PASSWD=''

export TERM=linux
export LC_CTYPE=zh_CN.UTF-8
export WINEDEBUG=-all

wskexe=$(basename $(find ~/webshellkill -maxdepth 1 -type f -name '*.exe' | head -n 1))

while true; do
    echo "[WSKDaemon] Starting WebShellKill ...."
    wine ~/webshellkill/$wskexe &
    echo "[WSKDaemon] Started WebShellKill ."
    wait
    echo "[WSKDaemon] WebShellKill exited, maybe updated."
    echo "[WSKDaemon] Searching for the new process ..."
    sleep 3
    wskpid=$(ps x | grep $wskexe | head -n 1 | awk '{print $1}')
    if [ "$wskpid" == "" ]; then
        echo "[WSKDaemon] No WebShellKill process found, start new process ..."
    else
        echo "[WSKDaemon] Found WebShellKill process, it's okay."
        tail -f /dev/null --pid=$wskpid
    fi
    echo "[WSKDaemon] WebShellKill exited. Killing wine ..."
    sleep 1
    wine wineboot --kill
    wineserver -k9
    echo "[WSKDaemon] WebShellKill will start after 3 seconds ..."
    sleep 3
done
