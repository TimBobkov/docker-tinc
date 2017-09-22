FROM debian:experimental

RUN echo "deb http://http.debian.net/debian experimental main" >> /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y net-tools cron && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -t experimental tinc && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV ADDRESS_FAMILY=none \
    AUTO_CONNECT=none \
    BIND_TO_ADDRESS=none \
    BROADCAST_SUBNET=none \
    CONNECT_TO=none \
    DEVICE=none \
    DEVICE_STANDBY=none \
    DEVICE_TYPE=none \
    EXPERIMENTAL_PROTOCOL=none \
    HOSTNAMES=none \
    INTERFACE=none \
    LISTEN_ADDRESS=none \
    LOCAL_DISCOVERY=none \
    LOG_LEVEL=none \
    MODE=none \
    INVITATION_EXPIRE=none \
    KEY_EXPIRE=none \
    MAC_EXPIRE=none \
    MAX_CONNECTION_BURST=none \
    NODENAME=default \
    PING_INTERVAL=none \
    PROCESS_PRIORITY=none \
    REPLAY_WINDOW=none \
    UDP_DISCOVERY=none \
    UDP_DISCOVERY_KEEPALIVE_INTERVAL=none \
    UDP_DISCOVERY_INTERVAL=none \
    UDP_DISCOVERY_TIMEOUT=none \
    UDP_INFO_INTERVAL=none \
    UDP_RCV_BUF=none \
    UDP_SND_BUF=none

ENV ADDRESS=none \
    CIPHER=none \
    CLAMP_MSS=none \
    COMPRESSION=none \
    DIGEST=none \
    INDIRECT_DATA=none \
    MAC_LENGTH=none \
    PMTU=none \
    PMTU_DISCOVERY=none \
    MTU_INFO_INTERVAL=none \
    PORT=655 \
    SUBNET=none \
    TCP_ONLY=none \
    WEIGHT=none

ENV VPN_IP="172.16.0.1"

RUN mkdir -p /usr/sbin/tinc
ADD config/run.sh /usr/sbin/tinc/run.sh
ADD config/tinc-* /etc/default/
RUN chmod +x /usr/sbin/run.sh && \
    mkdir -p /etc/tinc/hosts && \
    mkdir -p /usr/tinc-cron/scripts

EXPOSE 655/tcp 655/udp

VOLUME /etc/tinc

ENTRYPOINT ["/usr/sbin/"]
CMD ["run.sh"]