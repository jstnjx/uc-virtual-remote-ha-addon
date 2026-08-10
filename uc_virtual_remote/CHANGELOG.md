# Changelog

## 0.14.3

- Version mirrored automatically from UC Virtual Remote 0.14.3.

## 0.14.2

- Version mirrored automatically from UC Virtual Remote 0.14.2.

## 0.14.1

- Version mirrored from UC Virtual Remote 0.14.1.
- Fixes Home Assistant Ingress asset and management API routing so the add-on interface loads its CSS and JavaScript through the Ingress base path instead of the Home Assistant root.

## 0.14.0

- Adds Home Assistant support for both `amd64` and `aarch64` hosts.
- Based directly on the matching multi-architecture `ghcr.io/jstnjx/uc-virtual-remote-arm64:0.14.0` image.
- Runs the UC Virtual Remote Core, Web Configurator and internal Docker daemon natively on the Home Assistant host architecture.
- Keeps normal UC ARM64 integration tarballs compatible: native execution on ARM64 and process-scoped QEMU execution on AMD64.
- Does not install or modify a host-wide ARM64 `binfmt_misc` handler.
- Keeps the existing add-on slug so upgrades retain the same `/data` storage and add-on identity.

## 0.13.1

- Initial Home Assistant add-on release.
- Based directly on `ghcr.io/jstnjx/uc-virtual-remote-arm64:0.13.1`.
- Adds Home Assistant Ingress support in the upstream Web Configurator.
- Includes the upstream fix for the duplicate **Sync Mode** Settings tab.
- Supports native UC ARM64 integration tarballs and internal-Docker external integrations exactly as provided by UC Virtual Remote ARM64.
