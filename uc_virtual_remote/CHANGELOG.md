# Changelog

## 0.14.9

- Version mirrored from UC Virtual Remote 0.14.9.
- Adds a Docker-free registry runtime for Home Assistant OS hosts where nested Docker cannot run: supported Python and Node.js integrations are checked out from source, installed into isolated runtime environments and supervised as unprivileged processes.
- Fixes registry installation of official Python integrations such as Denon AVR on affected HAOS hosts instead of attempting `docker build` after the Docker runtime has already been marked unavailable.
- Keeps prebuilt-image-only registry installs on Docker-capable hosts and reports a clear compatibility error when an integration cannot use the source-process fallback.
- Restores all configured profiles in the Remote Simulator instead of filtering the selector to the old public demo profile.
- Fixes the authenticated `/api/events` event stream used by the Remote Simulator, restoring live entity, activity, profile and simulator updates in the Web Configurator.
- Keeps the existing entity control surfaces, activity overlays, remote button mappings and hardware-button simulation connected to the live Core APIs.

## 0.14.8

- Version mirrored from UC Virtual Remote 0.14.8.
- Fixes the Home Assistant OS startup regression introduced in 0.14.7 when Supervisor exposes `/sys/fs/cgroup` read-only or without a delegated cgroup v2 subtree.
- Cgroup and mount-namespace preparation for the internal Docker runtime is now best-effort instead of fatal.
- UC Virtual Remote Core, the Web Configurator and native custom integration tarballs continue to start when nested Docker cannot be used.
- Registry/external container integrations are degraded on affected HAOS hosts instead of preventing the entire add-on from starting.

## 0.14.7

- Version mirrored from UC Virtual Remote 0.14.7.
- Prepares a writable/delegated cgroup v2 hierarchy for the internal Docker daemon so registry-backed integration builds can start their build containers on Home Assistant.
- Fixes ARM64 PyInstaller onedir integrations on AMD64 by using a bootloader-compatible parent-process level instead of the invalid `-1` value.
- Treats `min_core_api` as informational for custom integration tarballs instead of rejecting packages before startup.
- Supports documented Node.js custom integration packages using `bin/driver.js` in addition to native `bin/driver` executables.
- Returns a concrete integration-start error instead of a generic HTTP 500 when an uploaded driver fails to open its Integration API port.
- Adds a Management reconciliation scan for stale/orphaned integration records and duplicate driver IDs, with conservative automatic repair for unreferenced stale records.

## 0.14.6

- Version mirrored from UC Virtual Remote 0.14.6.
- Fixes Home Assistant startup by explicitly requesting `SYS_ADMIN`, which the internal Docker runtime needs to create mount namespaces.
- Corrects the privilege guidance: `full_access` and Protection mode control broad device access, while Linux capabilities such as `SYS_ADMIN` are requested separately.
- Keeps the v0.14.5 ARM64 PyInstaller and helper-executable compatibility fixes.

## 0.14.5

- Version mirrored from UC Virtual Remote 0.14.5.
- Detects missing mount-namespace privilege at startup before attempting registry/external integration work.
- Fixes ARM64 PyInstaller onedir custom integrations on AMD64 while keeping QEMU process-scoped and avoiding host-wide `binfmt_misc` registration.
- Keeps secondary ARM64 package executables such as bundled Node and Whisper runtimes under scoped QEMU on AMD64 without modifying packaged shared libraries.

## 0.14.4

- Version mirrored automatically from UC Virtual Remote 0.14.4.

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
