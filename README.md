# UBNT Unifi Controller for Docker

Unofficial image for Ubiquiti UniFi Controller software.

## As a service

Requires *rkt* and *acbuild*.

```
make clean install
systemctl enable ubnt-unifi-controller.service
systemctl start ubnt-unifi-controller.service
```

## Docker

https://hub.docker.com/r/rkernan/ubnt-unifi-controller/tags/

Build:
```
docker build \
    --tag rkernan/ubnt-unifi-controller:latest \
    .
```

Run:
```
docker run \
    --detach \
    --restart=always \
    --publish 8080:8080 \
    --publish 8443:8443 \
    --publish 8880:8880 \
    --publish 8843:8843 \
    --volume /path/to/unifi/data:/usr/lib/unifi/data \
    --volume /path/to/unifi/logs:/usr/lib/unifi/logs \
    --name unifi-control \
    rkernan/ubnt-unifi-controller
```

## rkt

Build:
```
./accp.sh
```

Run:
```
systemd-run --slice=machine rkt run \
    --insecure-options=image \
    --volume data,kind=host,source=/path/to/unifi/data/,readOnly=false \
    --volume logs,kind=host,source=/path/to/unifi/logs,readOnly=false \
    --port=http:8080 \
    --port=https:8443 \
    --port=portal-http:8880 \
    --port=portal-https:8843 \
    $(pwd)/ubnt-unifi-controller.aci
```

## Ports

https://help.ubnt.com/hc/en-us/articles/218506997-UniFi-Ports-Used

- `unifi.http.port=8080` - Port for UAP to inform controller.
- `unifi.https.port=8443` - Port for controller GUI/API.
- `portal.http.port=8880` - Port for HTTP guest portal redirect.
- `portal.https.port=8843` - Port for HTTPS guest portal redirect.
- `unifi.db.port=27117` - Local-bound port for DB server.

## Set up SSL Certificate

https://help.ubnt.com/hc/en-us/articles/212500127-UniFi-SSL-certificate-error-upon-opening-controller-page

If `/usr/lib/unifi/data` is set up as a volume then the keystore will persist
between containers. Simply connect to the container and import the
certificate file into the keystore. In the examples below the certificate file
is `data/server.crt`.

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
