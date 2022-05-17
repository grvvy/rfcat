#!/bin/bash

for i in `seq 0 255`; do
  mknod /dev/ttyACM$i c 166 $i;
done