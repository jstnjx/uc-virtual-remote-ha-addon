# UC Virtual Remote ARM64

This add-on runs the upstream **UC Virtual Remote ARM64** appliance inside Home Assistant.

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

## Integrations

Normal UC ARM64 integration tarballs can be uploaded through the Web Configurator and run directly inside the appliance. External integrations continue to run as containers inside UC Virtual Remote's internal Docker daemon.

## Updates

The add-on version intentionally follows the upstream UC Virtual Remote ARM64 version. The add-on Dockerfile uses the same version as its upstream image, so it does not maintain an independent application codebase.

## Backup

The add-on uses cold backups. `/data` contains the complete persistent appliance state, including the internal Docker graph and uploaded native integrations, so backups can be substantially larger than a normal add-on backup.
