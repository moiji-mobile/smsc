# Clean stuff

all: build_clean package

NAME=OsmoSmsc
RDEPS_PARSE=`grep -r ^Depends debian/control | head -1 | sed -e "s/,//g" -e "s/Depends: //g" -e "s/\\\$${.*} //g" -e "s/ pharo.*\[.*\]//g"`
RDEPS="${RDEPS_PARSE} pharo-vm-core:i386"

.PHONY: build_clean install-rdepends
build_clean:
	@echo going to clean
	git clean -dxf .

install-rdepends:
	echo "deb http://download.opensuse.org/repositories/home:/zecke23/Debian_8.0/ ./" > /etc/apt/sources.list.d/obs.list
	wget -O - http://download.opensuse.org/repositories/home:/zecke23/Debian_8.0/Release.key | apt-key add -
	apt-get update
	DEBIAN_FRONTEND=noninteractive echo $(RDEPS) | xargs apt-get install -y --no-install-recommends --force-yes

install:
	mkdir -p $(DESTDIR)/usr/share/osmo-smsc/links
	mkdir -p $(DESTDIR)/usr/share/osmo-smsc/scripts
	mkdir -p $(DESTDIR)/usr/share/osmo-smsc/template/om/launch.d
	mkdir -p $(DESTDIR)/var/lib/pharo-images

	# install the image
	install -m 0644 $(NAME).image $(DESTDIR)/var/lib/pharo-images/$(NAME).image
	install -m 0644 $(NAME).changes $(DESTDIR)/var/lib/pharo-images/$(NAME).changes

	install -m 0755 template.runit $(DESTDIR)/usr/share/osmo-smsc/template/runit
	install -m 0644 function.om $(DESTDIR)/usr/share/osmo-smsc/scripts/om
	install -m 0644 function.syslog $(DESTDIR)/usr/share/osmo-smsc/scripts/syslog

	# launch examples
	install -m 0644 om.launch $(DESTDIR)/usr/share/osmo-smsc/template/om/image-launch.conf
