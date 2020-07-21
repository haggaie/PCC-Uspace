#!/bin/bash

latency="$1"
filename="$2"

sudo $ip netns exec numa0 env LD_PRELOAD=libvma.so ./pccserver recv 9999 > \
    server-$filename-$latency.txt &
server=$!
sudo $ip netns exec numa1 env LD_PRELOAD=libvma.so PCC_LATENCY="$latency" ./pccclient send 10.0.17.1 9999 | \
    tee client-$filename-$latency.txt &
client=$!
trap "sudo killall -9 pccclient ; sudo killall -9 pccserver" EXIT

sleep 30
