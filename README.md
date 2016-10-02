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
- `unifi.db.port=27117` - Local-bound port for DB server.

## Set up SSL Certificate

If `/usr/lib/unifi/data` is set up as a volume then the keystore will persist
between docker containers. Simply connect to the container and import the
certificate file into the keystore. In the example below the certificate file
is `data/server.crt`.

https://help.ubnt.com/hc/en-us/articles/212500127-UniFi-SSL-certificate-error-upon-opening-controller-page

```
[root@localhost ubnt-unifi-controller-docker]# docker exec -it unifi-control /bin/bash
root@fc64755c9d3e:/usr/lib/unifi# java -jar lib/ace.jar import_cert data/server.crt
parse server.crt (PEM, 1 certs): CN=localhost
Importing signed cert[localhost]
Certificates successfuly imported. Please restart the UniFi Controller.
root@fc64755c9d3e:/usr/lib/unifi# exit
exit
[root@localhost ubnt-unifi-controller-docker]# docker restart unifi-control
unifi-control
```
