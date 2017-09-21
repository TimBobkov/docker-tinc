FROM ubuntu:xenial

ENV NODENAME=default \
    MODE=none \
    INTERFACE=none \
    ADDRESS_FAMILY=none \
    MAIN_NODE=none \
    DEVICE=none \
    DEVICE_TYPE=none \
    HOSTNAMES=none \
    KEY_EXPIRE=none \
    MAC_EXPIRE=none \
    MAX_TIMEOUT=none \
    PING_INTERVAL=none \
    PING_TIMEOUT=none
ENV EXT_IP=none \
    CIPHER=none \
    CLAMP_MSS=none \
    COMPRESSION=none \
    DIGEST=none \
    INDIRECT_DATA=none \
    MAC_LENGTH=none \
    PMTU=none \
    PMTU_DISCOVERY=none \
    SUBNET=none \
    PORT=none

RUN apt-get update && \
    apt-get install -y net-tools tinc && \
    apt-get clean

ADD config/run.sh /etc/run.sh
RUN chmod +x /etc/run.sh && \
    mkdir -p /etc/tinc/hosts && \
    mkdir -p /usr/cron/scripts

EXPOSE 655

VOLUME /etc/tinc /usr/cron

CMD /etc/run.sh