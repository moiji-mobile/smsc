FROM debian

RUN dpkg --add-architecture i386 && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends wget make

RUN mkdir -p /tmp/osmo-smsc

ADD ./ /tmp/osmo-smsc

RUN make -C /tmp/osmo-smsc/ install-rdepends install && rm -rf /tmp/osmo-smsc

# reuse the start script
RUN cp /usr/bin/pharo-vm-nox /usr/bin/pharo-vm-nox.bak && \
    dpkg --purge pharo-vm-core && \
    mv /usr/bin/pharo-vm-nox.bak /usr/bin/pharo-vm-nox

COPY pharo-vm/*.so /usr/lib/pharo-vm/
COPY pharo-vm/vm-* /usr/lib/pharo-vm/
COPY pharo-vm/pharo /usr/lib/pharo-vm/pharo-vm

RUN ln -s /usr/lib/i386-linux-gnu/libcrypto.so.1.0.0 /usr/share/osmo-smsc/links/libcrypto.so && \
ln -s /usr/share/osmo-smsc/scripts/om /usr/share/osmo-smsc/template/om/launch.d/99-om && \
ln -s /usr/share/osmo-smsc/scripts/inserter /usr/share/osmo-smsc/template/inserter/launch.d/99-inserter


ADD ./docker/osmo-smsc-docker.sh /usr/local/bin/osmo-smsc
RUN chmod 755 /usr/local/bin/osmo-smsc
RUN sed -i -e "s/--db-host=127.0.0.1/--db-host=mongodb/g" /usr/share/osmo-smsc/template/om/image-launch.conf && \
    sed -i -e "s/--db-host=127.0.0.1/--db-host=mongodb/g" /usr/share/osmo-smsc/template/inserter/image-launch.conf

ENTRYPOINT ["/usr/local/bin/osmo-smsc"]
CMD ["osmo-smsc","om"]

EXPOSE 1700
