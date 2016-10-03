install_directory="/usr/local/lib/unifi"
aci_file="ubnt-unifi-controller.aci"

.PHONY: all
all: build

.PHONY: build
build: $(aci_file)

.PHONY: clean
clean:
	rm -f $(aci_file)

$(aci_file):
	./accp.sh

.PHONY: install
install: build
	mkdir -p /usr/local/lib/unifi
	mkdir -p $(install_directory)/data
	mkdir -p $(install_directory)/logs
	cp -f $(aci_file) /usr/local/lib/unifi/$(aci_file)
	cp -f ubnt-unifi-controller.service /usr/lib/systemd/system/
	systemctl daemon-reload

.PHONY: uninstall
uninstall:
	rm -f /usr/lib/systemd/system/ubnt-unifi-controller.service
	rm -rf $(install_directory)/{$(aci_file),logs}
	echo "Leaving /usr/local/lib/unifi/data in place"
