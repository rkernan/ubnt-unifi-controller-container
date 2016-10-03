#!/usr/bin/env sh
trap 'acbuild end' EXIT
set -xe
acbuild begin
acbuild dependency add quay.io/aptible/debian
acbuild copy 100-ubnt.list /etc/apt/sources.list.d/100-ubnt.list
acbuild run -- apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50
acbuild run -- apt-get update -q --assume-no
acbuild run -- apt-get install -qy unifi
acbuild mount add data /usr/lib/unifi/data
acbuild mount add logs /usr/lib/unifi/logs
acbuild port add http tcp 8080
acbuild port add https tcp 8443
acbuild port add portal-http tcp 8880
acbuild port add portal-https tcp 8443
acbuild set-working-directory /usr/lib/unifi
acbuild set-exec -- /usr/bin/java -jar lib/ace.jar start
acbuild set-name ubnt-unifi-controller
acbuild write --overwrite ubnt-unifi-controller.aci
