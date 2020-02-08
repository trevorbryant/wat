#!/bin/bash

list_files() {

    # locate and verify working directory
    files=$(find $1 -iname "*.*cap") 
    echo -e "\nLocated $(echo "$files" | wc -l) capture files ..."

}

create_inventory() {

    # tshark to extract info and create inventory
    /usr/bin/tshark -r $1 -R '(wlan.ssid ~ "WCTF_([0-9]{1,2}|W.*)")' -2 \
    -T fields -E header=n -E separator=, -E quote=d -E occurrence=a \
    -e wlan.ssid -e wlan.bssid \
    | sort -u

}

extract_handshake() {

    # extract handshakes
    macs=$(cat inventory.csv | cut -d, -f2| sed -e s/\://g)
    for mac in $macs
    do
	/usr/local/bin/hcxpcaptool -o $mac.hccapx $1 --filtermac=$mac
    done

}

aircrack_handshake() {

    # if not exist, create dir
    [[ -d aircrack ]] || mkdir aircrack

    macs=$(cat inventory.csv | cut -d, -f2)
    for mac in $macs
    do
        aircrack-ng -r /root/wifi/dbs/wctfdb $1 -b $mac -1 -l aircrack/$1.aircracked
        grep FOUND $1 | sed -i -e "s,\x1B\[[0-9;]*[a-zA-Z],,g" $1
    done

}

hashcat_handshake() {

   # if not exist, create dir
   [[ -d hashcat ]] || mkdir hashcat

   /usr/bin/hashcat -m 2500 $1 /usr/share/wordlists/cyberpunk.words -o hashcat/$1.hashcat --force 2>/dev/null

}

list_files $1
echo -e "Creating inventory ..."

for file in $files;
do
    create_inventory $file
done | sort -u | tee inventory.csv
sed -i -e s/\"//g inventory.csv

for file in $files;
do
    echo -e "\nExtracting handshakes for $file ..."
    extract_handshake $file
done

for file in $(ls *.hccapx);
do
    echo -e "\naircrack-ng: cracking $file"
    aircrack_handshake $file
done

for file in $(ls *.hccapx);
do
    echo -e "\nhashcat: cracking $file"
    hashcat_handshake $file
done
