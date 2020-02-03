#!/bin/bash

list_files() {

    # locate and save capture files
    files=$(find $1 -iname *.*cap)
    echo -e "Located $(echo "$files" | wc -l) capture files ..."

}

create_inventory() {
    
    # validate pathname, extract filename
    if [ -e $(find $1) ];
    then
	pcap=$(find $1 -printf "%f\n")
    else
	return
    fi

    # create AP inventory
    /usr/bin/tshark -r $1 -R '(wlan.ssid ~ "WCTF_[0-9]{1,2}")' -2 \
    -T fields -E header=n -E separator=, -E quote=d -E occurrence=a \
    -e wlan.ssid -e wlan.bssid \
    | sort -u

}

extract_handshake() {

    # validate pathname, extract filename
    if [ -e $(find $1) ];
    then
	pcap=$(find $1 -printf "%f\n")
    else
	return
    fi

    # extract handshakes
    macs=$(cat inventory.csv | cut -d, -f2 | sed -e s/\://g)
    for mac in $macs
    do
        /usr/local/bin/hcxpcaptool -o $aps_$mac.hccapx $1 --filtermac=$mac
    done

}

aircrack_handshake() {
  
    [[ -d aircrack ]] || mkdir aircrack

    macs=$(cat inventory.csv | cut -d, -f2)
    for mac in $macs
    do
	echo $mac $1
	out=$(cat inventory.csv | cut -d, -f2 | sed -e s/\://g)
	aircrack-ng -r /root/wifi/dbs/wctfdb $1 -b $mac -1 -l aircrack/$1.aircracked #> /dev/null 2>&1
	grep FOUND $1 | sed -i -e "s,\x1B\[[0-9;]*[a-zA-Z],,g" $1
    done

}

hashcat_handshake() {

    [[ -d hashcat ]] || mkdir hashcat

    # validate pathname, extract filename
    if [ -e $(find $1) ];
    then
	pcap=$(find $1 -printf "%f\n")
    else
        return
    fi

    # crack handshake(s)
    /usr/local/bin/hashcat -m 2500 $pcap /usr/share/wordlists/cyberpunk.words -o hashcat/$pcap.hashcracked 2>/dev/null

}

echo -e "\nCreating inventory ..."
list_files $1

for file in $files; 
do 
    create_inventory $file
done | sort -u | tee inventory.csv
sed -i -e s/\"//g inventory.csv

#create_inventory $1 | tee $(find $1 -printf "%f\n").csv

for file in $files;
do
    echo -e "\nExtracting handshakes for $file ..."
    extract_handshake $file
done

for file in $(ls *.hccapx);
do
    echo -e "\naircrack-ng: cracking $file ..."
    aircrack_handshake $file
done

hsfile=$(find *.hccapx)
for hs in $hsfile;
do 
    echo -e "\nCracking handshakes for $hs ..."
    hashcat_handshake $hs
done
