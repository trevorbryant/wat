#!/bin/bash

for i in $(ifconfig -a | grep wlx | cut -d: -f1)
do
         airmon-ng start $i >/dev/null 2>/dev/null
done
airmon-ng
