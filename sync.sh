#!/bin/bash
# improve later
while true; do sleep 15 && rsync -avh user@10.112.10.11:/home/user/path/to/pcap .; done
