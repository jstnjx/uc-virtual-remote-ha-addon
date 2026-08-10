# UC Virtual Remote ARM64 — Home Assistant Add-on

Home Assistant packaging for [UC Virtual Remote ARM64](https://github.com/jstnjx/uc-virtual-remote-arm64).

> This repository is **not another UC Virtual Remote codebase**. It contains only Home Assistant repository metadata, the add-on descriptor, and a small startup wrapper. The add-on Dockerfile always inherits the matching `ghcr.io/jstnjx/uc-virtual-remote-arm64:<version>` image.

## Install

Add this repository to the Home Assistant app/add-on store:

```text
https://github.com/jstnjx/uc-virtual-remote-ha-addon
```

Install **UC Virtual Remote ARM64**, disable **Protection mode**, and start it.

The Web Configurator is available through **Open Web UI** / Home Assistant Ingress and directly at:

```text
http://HOME_ASSISTANT_HOST:11090/configurator/
```

The Remote Core WebSocket remains available on port `946` for physical remotes and integrations on the local network.

## Architecture

```text
Home Assistant OS / Supervisor
└─ UC Virtual Remote ARM64 add-on
   ├─ UC Virtual Remote Core
   ├─ Web Configurator
   ├─ native ARM64 integration processes
   └─ internal dockerd
      └─ external UC integration containers
```

All application code comes from `uc-virtual-remote-arm64`. Add-on version `X.Y.Z` builds from upstream image `ghcr.io/jstnjx/uc-virtual-remote-arm64:X.Y.Z`.

## Security requirement

The ARM64 appliance runs its own Docker daemon for external integrations. The Home Assistant add-on therefore requires host networking, full/privileged access, host D-Bus access, and disabled AppArmor. Home Assistant assigns apps using `full_access` the lowest security rating. Only install this add-on if you trust both repositories and the integration containers you install through UC Virtual Remote.

## Persistent data

Home Assistant's `/data` volume stores the complete appliance state, including:

- Remote configuration
- native integration packages and configuration
- native integration logs
- internal Docker image/container state
- application update state

Backups use cold mode so Home Assistant stops UC Virtual Remote while the add-on data is captured.

## Source

- UC Virtual Remote ARM64: https://github.com/jstnjx/uc-virtual-remote-arm64
- Home Assistant packaging: https://github.com/jstnjx/uc-virtual-remote-ha-addon
