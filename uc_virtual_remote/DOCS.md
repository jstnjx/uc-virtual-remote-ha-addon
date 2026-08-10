# UC Virtual Remote

This add-on runs the upstream **UC Virtual Remote** appliance inside Home Assistant on `aarch64` and `amd64` systems.

## Before starting

The appliance contains an internal Docker daemon. After installation, open the add-on's **Configuration / Info** page and disable **Protection mode** before starting it. Full access is required for nested Docker and hardware/network services.

## Configuration

### `pin`
Four-digit PIN used by the Web Configurator. Default: `1234`.

### `remote_name`
Display name presented by the virtual Remote Core. Default: `Virtual Remote 3`.

### `log_level`
Backend logging level: `debug`, `info`, `warn`, or `error`.

### `dind_storage_driver`
Storage driver used by the internal Docker daemon. `overlay2` is preferred. Use `vfs` if the Home Assistant host does not support nested overlay filesystems.

### `github_token`
Optional GitHub token used by UC Virtual Remote for private integration repositories or GitHub API access. Leave it unset unless required.

## Access

Use **Open Web UI** to open the Web Configurator through Home Assistant Ingress.

Direct LAN endpoints are also available because the Remote Core and its integrations need host networking:

```text
Web Configurator: http://HOME_ASSISTANT_HOST:11090/configurator/
Management/API:   http://HOME_ASSISTANT_HOST:11090/
Core WebSocket:   ws://HOME_ASSISTANT_HOST:946/ws
```

## Architecture and integrations

The UC Virtual Remote Core, Web Configurator and internal Docker daemon run natively for the Home Assistant host architecture.

Normal UC ARM64 integration tarballs remain unchanged:

- on `aarch64`, ARM64 driver binaries run directly;
- on `amd64`, only those ARM64 driver processes are launched through the bundled `qemu-aarch64-static` userspace emulator;
- no host-wide ARM64 `binfmt_misc` registration is installed or required.

External integrations continue to run as containers inside UC Virtual Remote's internal Docker daemon. Source-built external integrations build for the host architecture. Prebuilt external images need a compatible host-architecture variant or a registry source-build fallback.

## Updates and versioning

`uc-virtual-remote-arm64` is the only version authority. The Home Assistant add-on does not maintain an independent version line.

The add-on's required literal `version:` field is mirrored automatically from the latest published upstream release. The mirror only commits after the matching public `amd64` + `arm64` image exists and both wrapper builds succeed. CI rejects any add-on version that differs from the latest upstream release.

Therefore, application releases are made only in `uc-virtual-remote-arm64`; this packaging repository follows them automatically.

## Backup

The add-on uses cold backups. `/data` contains the complete persistent appliance state, including the internal Docker graph and uploaded native integrations, so backups can be substantially larger than a normal add-on backup.
