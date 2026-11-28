#!/usr/bin/env bash
# Docker 25.0.2 forgets configured MAC addresses when a container restarts.
# Run after every Dev Container start, before terminals become available.
set -euo pipefail
expected=10:91:d1:3d:14:ae
actual=$(cat /sys/class/net/eth0/address)
if [[ $actual != "$expected" ]]; then
    echo "Restoring container eth0 MAC: $actual -> $expected"
    if ! sudo -n ip link set dev eth0 address "$expected"; then
        echo "Cannot restore the container MAC. Rebuild Container to apply NET_ADMIN and the network settings." >&2
        exit 1
    fi
fi
actual=$(cat /sys/class/net/eth0/address)
if [[ $actual != "$expected" ]]; then
    echo "Container eth0 MAC is $actual; expected $expected." >&2
    exit 1
fi
echo "Container eth0 MAC: $actual"
