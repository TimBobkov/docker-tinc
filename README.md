### Supported tags
* `1.1`, `test` [*(Dockerfile)*](https://github.com/TimBobkov/docker-tinc/blob/master/tinc1.1/Dockerfile)
* `1.0`, `latest`, `stable` [*(Dockerfile)*](https://github.com/TimBobkov/docker-tinc/blob/master/tinc1.0/Dockerfile)

### Using
* Required: define node name by using NODENAME environment and VPN IP address of the node by using VPN_IP environment. With sample configuration node just listen for incoming connections.
* Optional:
1. With tinc 1.0 you can use environments: main configuration - `ADDRESS_FAMILY`, `CONNECT_TO`, `DEVICE`, `DEVICE_TYPE`, `HOSTNAMES`, `KEY_EXPIRE`, `MAC_EXPIRE`, `MAX_TIMEOUT`, `PING_INTERVAL`, `PING_TIMEOUT` which are corresponding to main configuration variables of tinc 1.0; host configuration - `ADDRESS`, `CIPHER`, `CLAMP_MSS`, `COMPRESSION`, `DIGEST`, `INDIRECT_DATA`, `MAC_LENGTH`, `PMTU`, `PMTU_DISCOVERY`, `SUBNET`, `PORT` which are corresponding to host configuration variables of tinc 1.0. More about variables you can read at [tinc-vpn.org](http://tinc-vpn.org/documentation/).
2. With tinc 1.1 you can use environments: main configuration - `ADDRESS_FAMILY`, `AUTO_CONNECT`, `BIND_TO_ADDRESS`, `BROADCAST_SUBNET`, `CONNECT_TO`, `DEVICE`, `DEVICE_STANDBY`, `DEVICE_TYPE`, `EXPERIMENTAL_PROTOCOL`, `HOSTNAMES`, `INTERFACE`, `LISTEN_ADDRESS`, `LOCAL_DISCOVERY`, `LOG_LEVEL`, `MODE`, `INVITATION_EXPIRE`, `KEY_EXPIRE`, `MAC_EXPIRE`, `MAX_CONNECTION_BURST`, `PING_INTERVAL`, `PROCESS_PRIORITY`, `REPLAY_WINDOW`, `UDP_DISCOVERY`, `UDP_DISCOVERY_KEEPALIVE_INTERVAL`, `UDP_DISCOVERY_INTERVAL`, `UDP_DISCOVERY_TIMEOUT`, `UDP_INFO_INTERVAL`, `UDP_RCV_BUF`, `UDP_SND_BUF` which are corresponding to main configuration variables of tinc 1.1; host configuration - `ADDRESS`, `CIPHER`, `CLAMP_MSS`, `COMPRESSION`, `DIGEST`, `INDIRECT_DATA`, `MAC_LENGTH`, `PMTU`, `PMTU_DISCOVERY`, `MTU_INFO_INTERVAL`, `PORT`, `SUBNET`, `TCP_ONLY`, `WEIGHT` which are corresponding to host configuration variables of tinc 1.1. More about variables you can read at [tinc-vpn.org](http://tinc-vpn.org/documentation-1.1/).
### Examples
The easiest way to use the image - use it with Docker Compose:
```yaml
version: '2'
services:
  tinc:
    image: timbobkov/tinc
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/net/tun
    environment:
      - NODENAME=node0
      - VPN_IP=172.16.0.1
    ports:
      - 655/tcp
      - 655/udp
    container_name: tinc
```
#### Volumes
1. If you want get access to tinc configuration files you need to add `- /local/path:/etc/tinc` to volumes configuration.
2. For using custom tinc scripts add `- /local/path:/etc/tinc/scripts:ro`, put scripts to /local/path folder and restart container with `docker-compose restart`
3. For using CRON add `- /local/path:/usr/tinc-cron`. CRON job files should be at /local/path, corresponding scripts and files put at /local/path/scripts. Don`t forget restart container.
Example:
```yaml
version: '2'
services:
  tinc:
    image: timbobkov/tinc
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/net/tun
    environment:
      - NODENAME=node0
      - VPN_IP=172.16.0.1
    volumes:
      - ./config:/etc/tinc
      - ./scripts:/etc/tinc/scripts:ro
      - ./cron:/usr/tinc-cron
    ports:
      - 655/tcp
      - 655/udp
    container_name: tinc
```
#### Access to VPN from host machine
For accessing to VPN from host machine add `network_mode: host` to docker-compose.yml
Example:
```yaml
version: '2'
services:
  tinc:
    image: timbobkov/tinc
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/net/tun
    environment:
      - NODENAME=node0
      - VPN_IP=172.16.0.1
    ports:
      - 655/tcp
      - 655/udp
    network_mode: host
    container_name: tinc
```
#### Access to VPN from other docker containers
For accessing to VPN from other containers you should add `network_mode: container:tinc` to docker-compose.yml of this containers (if you using Docker Compose) or corresponding `--net` parameter (if you using docker run). More about this options read in docker run or docker-compose.yml references.

