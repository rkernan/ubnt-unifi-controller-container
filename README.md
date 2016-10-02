# UBNT Unifi Controller for Docker

https://hub.docker.com/r/rkernan/ubnt-unifi-controller/tags/

Unofficial Docker image for Ubiquiti UniFi Controller software.

## Build

```
docker build \
    --tag rkernan/ubnt-unifi-controller:latest \
    .
```

## Run

```
docker run \
    --detach \
    --restart=always \
    --publish 8080:8080 \
    --publish 8443:8443 \
    --publish 8880:8880 \
    --publish 8843:8843 \
    --volume /path/to/unifi/data:/usr/lib/unifi/data \
    --name unifi-control \
    rkernan/ubnt-unifi-controller
```

## Ports

https://help.ubnt.com/hc/en-us/articles/218506997-UniFi-Ports-Used

- `unifi.http.port=8080` - Port for UAP to inform controller.
- `unifi.https.port=8443` - Port for controller GUI/API.
- `portal.http.port=8880` - Port for HTTP guest portal redirect.
- `portal.https.port=8843` - Port for HTTPS guest portal redirect.
- `unifi.db.port=27117` - Local-bound port for DB server. Do not need to expose.
