#!/usr/bin/env bash
tinc="/etc/tinc"
hosts="$tinc/hosts"
echo "Name = $NODENAME" > $tinc/tinc.conf
if [ "$MODE" != "none" ]; then echo "Mode = $MODE" >> $tinc/tinc.conf; fi
if [ "$INTERFACE" != "none" ]; then echo "Interface = $INTERFACE" >> $tinc/tinc.conf; fi
if [ "$ADDRESS_FAMILY" != "none" ]; then echo "AddressFamily = $ADDRESS_FAMILY" >> $tinc/tinc.conf; fi
if [ "$MAIN_NODE" != "none" ]; then echo "ConnectTo = $MAIN_NODE" >> $tinc/tinc.conf; fi
if [ "$DEVICE" != "none" ]; then echo "Device = $DEVICE" >> $tinc/tinc.conf; fi
if [ "$DEVICE_TYPE" != "none" ]; then echo "DeviceType = $DEVICE_TYPE" >> $tinc/tinc.conf; fi
if [ "$HOSTNAMES" != "none" ]; then echo "Hostnames = $HOSTNAMES" >> $tinc/tinc.conf; fi
if [ "$KEY_EXPIRE" != "none" ]; then echo "KeyExpire = $KEY_EXPIRE" >> $tinc/tinc.conf; fi
if [ "$MAC_EXPIRE" != "none" -a "$MODE" = "switch" ]; then echo "MACExpire = $MAC_EXPIRE" >> $tinc/tinc.conf; fi
if [ "$MAX_TIMEOUT" != "none" ]; then echo "MaxTimeout = $MAX_TIMEOUT" >> $tinc/tinc.conf; fi
if [ "$PING_INTERVAL" != "none" ]; then echo "PingInterval = $PING_INTERVAL" >> $tinc/tinc.conf; fi
if [ "$PING_TIMEOUT" != "none" ]; then echo "PingTimeout = $PING_TIMEOUT" >> $tinc/tinc.conf; fi

if [ -f $hosts/$NODENAME ]; then rm $hosts/$NODENAME; fi
if [ "$EXT_IP" != "none" ]; then echo "Address = $EXT_IP" >> $hosts/$NODENAME; fi
if [ "$CIPHER" != "none" ]; then echo "Cipher = $CIPHER" >> $hosts/$NODENAME; fi
if [ "$CLAMP_MSS" != "none" ]; then echo "ClampMSS = $CLAMP_MSS" >> $hosts/$NODENAME; fi
if [ "$COMPRESSION" != "none" ]; then echo "Compression = $COMPRESSION" >> $hosts/$NODENAME; fi
if [ "$DIGEST" != "none" ]; then echo "Digest = $DIGEST" >> $hosts/$NODENAME; fi
if [ "$INDIRECT_DATA" != "none" ]; then echo "IndirectData = $INDIRECT_DATA" >> $hosts/$NODENAME; fi
if [ "$MAC_LENGTH" != "none" ]; then echo "MACLength = $MAC_LENGTH" >> $hosts/$NODENAME; fi
if [ "$PMTU" != "none" ]; then echo "PMTU = $PMTU" >> $hosts/$NODENAME; fi
if [ "$PMTU_DISCOVERY" != "none" ]; then echo "PMTUDiscovery = $PMTU_DISCOVERY" >> $hosts/$NODENAME; fi
if [ "$SUBNET" != "none" ]; then echo "Subnet = $SUBNET" >> $hosts/$NODENAME; fi
if [ "$PORT" != "none" ]; then echo "Port = $PORT" >> $hosts/$NODENAME; fi
echo "\n\n" | tincd -K4096

crontab -d
dir=/usr/cron
filecount=`find $dir -type f -not -path "$dir/.*" -not -type d | wc -l`
if [ $filecount -gt "0" ]; then
    for file in $(find $dir -type f -not -path "$dir/.*" -not -path "$dir/scripts/*" -print); do
        crontab file
    done
fi

tincd

