# UC Virtual Remote — Home Assistant Add-on

Home Assistant packaging for [UC Virtual Remote](https://github.com/jstnjx/uc-virtual-remote-arm64), supporting both ARM64 and AMD64 Home Assistant hosts.

> This repository is **not another UC Virtual Remote codebase**. It contains only Home Assistant repository metadata, the add-on descriptor, and a small startup wrapper. The add-on Dockerfile always inherits the matching `ghcr.io/jstnjx/uc-virtual-remote-arm64:<version>` image.

## Versioning

`uc-virtual-remote-arm64` is the **only version authority**. This add-on has no independent application version or release line.

When a new upstream release is published, the add-on repository automatically mirrors that exact version into `config.yaml` after the matching public `amd64` + `arm64` GHCR image is available and both Home Assistant wrapper builds validate successfully. CI rejects any add-on version that does not exactly match the latest upstream release.

## Install

Add this repository to the Home Assistant app/add-on store:

```text
https://github.com/jstnjx/uc-virtual-remote-ha-addon
```

Install **UC Virtual Remote**, disable **Protection mode**, and start it.

The Web Configurator is available through **Open Web UI** / Home Assistant Ingress and directly at:

```text
http://HOME_ASSISTANT_HOST:11090/configurator/
```

The Remote Core WebSocket remains available on port `946` for physical remotes and integrations on the local network.

## Architecture

```text
Home Assistant OS / Supervisor (aarch64 or amd64)
└─ UC Virtual Remote add-on
   ├─ host-native UC Virtual Remote Core
   ├─ Web Configurator
   ├─ ARM64 UC integration processes
   │  └─ direct on ARM64 / scoped QEMU on AMD64
   └─ internal dockerd
      └─ external UC integration containers
```

All application code comes from `uc-virtual-remote-arm64`. Add-on version `X.Y.Z` builds from upstream image `ghcr.io/jstnjx/uc-virtual-remote-arm64:X.Y.Z`; Docker selects the matching ARM64 or AMD64 image variant automatically.

## Security requirement

The appliance runs its own Docker daemon for external integrations. The Home Assistant add-on therefore requires host networking, full/privileged access, host D-Bus access, and disabled AppArmor. Home Assistant assigns apps using `full_access` the lowest security rating. Only install this add-on if you trust both repositories and the integration containers you install through UC Virtual Remote.

AMD64 support does not install a host-wide ARM64 `binfmt_misc` handler. Normal Remote ARM64 integration binaries are launched through the emulator bundled inside the UC Virtual Remote AMD64 image only.

## Persistent data

Home Assistant's `/data` volume stores the complete appliance state, including:

- Remote configuration
- native integration packages and configuration
- native integration logs
- internal Docker image/container state
- application update state

Backups use cold mode so Home Assistant stops UC Virtual Remote while the add-on data is captured.

## Source

- UC Virtual Remote: https://github.com/jstnjx/uc-virtual-remote-arm64
- Home Assistant packaging: https://github.com/jstnjx/uc-virtual-remote-ha-addon
