# UC Virtual Remote

Run the complete UC Virtual Remote appliance as a Home Assistant add-on on `aarch64` or `amd64` hosts.

The add-on includes:

- Web Configurator through Home Assistant Ingress
- normal UC ARM64 integration tarball installation
- native integration process supervision
- direct ARM64 integration execution on ARM64 and scoped QEMU execution on AMD64
- internal Docker runtime for external integrations
- persistent configuration and integration data
- cold Home Assistant backups

This add-on does **not** contain a separate copy of UC Virtual Remote. Its Dockerfile inherits the matching `ghcr.io/jstnjx/uc-virtual-remote-arm64:<version>` image and only adds Home Assistant startup/configuration glue.

> **Protection mode must be disabled.** The upstream appliance runs an internal Docker daemon and therefore requires full container access.

See [DOCS.md](DOCS.md) for configuration and access details.
