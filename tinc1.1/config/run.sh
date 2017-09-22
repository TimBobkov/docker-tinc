#!/usr/bin/env bash

tinc="/etc/tinc"
scripts="/etc/tinc/scripts"
rm $tinc/tinc.conf
crontab -d

if [ ! -f $tinc/hosts/$NODENAME ]; then tinc init $NODENAME; fi
if [ "$ADDRESS_FAMILY" != "none" ]; then tinc set AddressFamily $ADDRESS_FAMILY; fi
if [ "$AUTO_CONNECT" != "none" ]; then tinc set AutoConnect $AUTO_CONNECT; fi
if [ "$BIND_TO_ADDRESS" != "none" ]; then tinc set BindToAddress $BIND_TO_ADDRESS; fi
if [ "$BROADCAST_SUBNET" != "none" ]; then tinc set BroadcastSubnet $BROADCAST_SUBNET; fi
if [ "$CONNECT_TO" != "none" ]; then
    for i in $CONNECT_TO; do
        echo "ConnectTo = $i" >> $tinc/tinc.conf
    done
fi
if [ "$DEVICE" != "none" ]; then tinc set Device $DEVICE; fi
if [ "$DEVICE_STANDBY" != "none" ]; then tinc set DeviceStandby $DEVICE_STANDBY; fi
if [ "$DEVICE_TYPE" != "none" ]; then tinc set DeviceType $DEVICE_TYPE; fi
if [ "$EXPERIMENTAL_PROTOCOL" != "none" ]; then tinc set ExperimentalProtocol $EXPERIMENTAL_PROTOCOL; fi
if [ "$HOSTNAMES" != "none" ]; then tinc set Hostnames $HOSTNAMES; fi
if [ "$INTERFACE" != "none" ]; then tinc set Interface $INTERFACE; fi
if [ "$LISTEN_ADDRESS" != "none" ]; then tinc set ListenAddress $LISTEN_ADDRESS; fi
if [ "$LOCAL_DISCOVERY" != "none" ]; then tinc set LocalDiscovery $LOCAL_DISCOVERY; fi
if [ "$LOG_LEVEL" != "none" ]; then tinc set LogLevel $LOG_LEVEL; fi
if [ "$MODE" != "none" ]; then tinc set Mode $MODE; fi
if [ "$INVITATION_EXPIRE" != "none" ]; then tinc set InvitationExpire $INVITATION_EXPIRE; fi
if [ "$KEY_EXPIRE" != "none" ]; then tinc set KeyExpire $KEY_EXPIRE; fi
if [ "$MAC_EXPIRE" != "none" ]; then tinc set MACExpire $MAC_EXPIRE; fi
if [ "$MAX_CONNECTION_BURST" != "none" ]; then tinc set MaxConnectionBurst $MAX_CONNECTION_BURST; fi
if [ "$PING_INTERVAL" != "none" ]; then tinc set PingInterval $PING_INTERVAL; fi
if [ "$PROCESS_PRIORITY" != "none" ]; then tinc set ProcessPriority $PROCESS_PRIORITY; fi
if [ "$REPLAY_WINDOW" != "none" ]; then tinc set ReplayWindow $REPLAY_WINDOW; fi
if [ "$UDP_DISCOVERY" != "none" ]; then tinc set UDPDiscovery $UDP_DISCOVERY; fi
if [ "$UDP_DISCOVERY_KEEPALIVE_INTERVAL" != "none" ]; then tinc set UDPDiscoveryKeepaliveInterval $UDP_DISCOVERY_KEEPALIVE_INTERVAL; fi
if [ "$UDP_DISCOVERY_INTERVAL" != "none" ]; then tinc set UDPDiscoveryInterval $UDP_DISCOVERY_INTERVAL; fi
if [ "$UDP_DISCOVERY_TIMEOUT" != "none" ]; then tinc set UDPDiscoveryTimeout $UDP_DISCOVERY_TIMEOUT; fi
if [ "$UDP_INFO_INTERVAL" != "none" ]; then tinc set UDPInfoInterval $UDP_INFO_INTERVAL; fi
if [ "$UDP_RCV_BUF" != "none" ]; then tinc set UDPRcvBuf $UDP_RCV_BUF; fi
if [ "$UDP_SND_BUF" != "none" ]; then tinc set UDPSndBuf $UDP_SND_BUF; fi

if [ "$ADDRESS" != "none" ]; then tinc set $NODENAME.Address $ADDRESS; fi
if [ "$CIPHER" != "none" ]; then tinc set $NODENAME.Cipher $CIPHER; fi
if [ "$CLAMP_MSS" != "none" ]; then tinc set $NODENAME.ClampMSS $CLAMP_MSS; fi
if [ "$COMPRESSION" != "none" ]; then tinc set $NODENAME.Compression $COMPRESSION; fi
if [ "$DIGEST" != "none" ]; then tinc set $NODENAME.Digest $DIGEST; fi
if [ "$INDIRECT_DATA" != "none" ]; then tinc set $NODENAME.IndirectData $INDIRECT_DATA; fi
if [ "$MAC_LENGTH" != "none" ]; then tinc set $NODENAME.MACLength $MAC_LENGTH; fi
if [ "$PMTU" != "none" ]; then tinc set $NODENAME.PMTU $PMTU; fi
if [ "$PMTU_DISCOVERY" != "none" ]; then tinc set $NODENAME.PMTUDiscovery $PMTU_DISCOVERY; fi
if [ "$MTU_INFO_INTERVAL" != "none" ]; then tinc set $NODENAME.MTUInfoInterval $MTU_INFO_INTERVAL; fi
if [ $PORT -ne "655" ]; then tinc set $NODENAME.Port $PORT; fi
if [ "$SUBNET" != "none" ]; then tinc set $NODENAME.Subnet $SUBNET; fi
if [ "$TCP_ONLY" != "none" ]; then tinc set $NODENAME.TCPOnly $TCP_ONLY; fi
if [ "$WEIGHT" != "none" ]; then tinc set $NODENAME.Weight $WEIGHT; fi

dir=/usr/cron
filecount=`find $dir -type f -not -path "$dir/.*" -not -type d | wc -l`
if [ $filecount -gt "0" ]; then
    for file in $(find $dir -type f -not -path "$dir/.*" -not -path "$dir/scripts/*" -print); do
        crontab file
    done
fi

vars=`cat $scripts/list`
for i in $vars; do
    if [ -f $scripts/$i ]; then
        cp $scripts/$i $tinc/$i
        chmod +x $tinc/$i
    fi
done

tinc start -D --logfile=/etc/tinc/log