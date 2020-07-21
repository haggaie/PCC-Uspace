#!/bin/bash

latencies=(0 0.000001 0.00001 0.0001 0.001 0.01 0.1 1)
iterations=$(seq 5)

for latency in ${latencies[@]} ; do
    for iter in $iterations ; do
        ./run-one.sh $latency $iter
    done
done
