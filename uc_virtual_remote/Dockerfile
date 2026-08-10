ARG BUILD_VERSION
FROM ghcr.io/jstnjx/uc-virtual-remote-arm64:${BUILD_VERSION}

ARG BUILD_VERSION
ARG BUILD_ARCH

LABEL \
  io.hass.version="${BUILD_VERSION}" \
  io.hass.type="app" \
  io.hass.arch="${BUILD_ARCH}" \
  org.opencontainers.image.source="https://github.com/jstnjx/uc-virtual-remote-ha-addon" \
  org.opencontainers.image.title="UC Virtual Remote Home Assistant Add-on"

COPY run.sh /usr/local/bin/ucvr-ha-addon
RUN chmod 0755 /usr/local/bin/ucvr-ha-addon

ENTRYPOINT ["/usr/local/bin/ucvr-ha-addon"]
CMD []
