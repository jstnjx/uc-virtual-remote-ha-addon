# Changelog

## 0.15.1

- Version mirrored from UC Virtual Remote 0.15.1.
- Fixes Management-interface updates failing with **“App self does not exist in the store”** on Home Assistant installations.
- Delegates Supervisor-managed self-updates through Home Assistant Core's `update.install` service instead of the Supervisor Store endpoint that deliberately forbids an add-on from updating itself.
- Enables `homeassistant_api` access so UC Virtual Remote can use Supervisor's authenticated Home Assistant Core API proxy for the delegated update.
- Resolves the Home Assistant update entity dynamically, including installations where its entity ID was renamed.
- Keeps standalone Docker self-updates unchanged.

## 0.15.0

- Version mirrored from UC Virtual Remote 0.15.0.
- Adds full Voice Assistant support with `voice_assistant` entities, assistant lifecycle events, binary protobuf voice streaming, and manual, ALSA, HTTP(S), and RTSP(S) audio inputs.
- Updates advertised compatibility to REST Core API `0.46.0`, WebSocket Core API `0.35.3-beta`, and Integration API `0.15.4-beta` with current voice, runtime-info, active-profile, Bluetooth, logging, Dock, media, Wi-Fi, standby, and activity-button semantics.
- Adds real Bluetooth LE HID over GATT/HOGP using the host BlueZ stack, including keyboard, relative mouse, consumer/media, system-control, modifier combinations, raw HID usages, `remote.send_cmd`, `remote.send_key`, and US-ASCII text support.
- Adds current Dock `SET_VOLUME` handling with persisted and clamped volume state plus Dock state events.
- Adds regression coverage for Voice Assistant protobuf/WebSocket transport, selectable audio sources, Bluetooth LE HID reports and command grammar, Integration API runtime info, active-profile events, API parity, and Dock volume behavior.
- The add-on continues to expose the host D-Bus and device access required for BlueZ-backed Bluetooth HID; local microphone capture requires an ALSA-visible input device.

## 0.14.17

- Version mirrored from UC Virtual Remote 0.14.17.
- Fixes settings that could appear saved but later revert because the Web Configurator replayed a stale cached copy of the entire configuration section when changing one field.
- Single-setting changes are now sent as partial PATCHes, preserving sibling values such as display/button lighting, Bluetooth/Wi-Fi, Power Saving, Sound and other multi-field settings.
- Restores explicitly persisted Bluetooth power, Wi-Fi power and Bluetooth HCI logging state after an add-on restart without applying default radio states to the Home Assistant host.
- Exposes persisted Voice Control configuration through the `voice` compatibility key expected by Web Configurator 2.3.3 and keeps configuration-change events synchronized with it.
- Fixes the Haptic Feedback toggle writing the Sound Effects toggle value instead of its own value.
- Adds restart-persistence regression coverage for display brightness, button-backlight brightness/color, Bluetooth/HCI state and Voice Control.

## 0.14.16

- Version mirrored from UC Virtual Remote 0.14.16.
- Clarifies Sync Mode's synchronization levels so **live usage**, **configuration-change sync**, **periodic reconciliation**, and the **daily full audit** are no longer presented as one timer-driven sync mechanism.
- Renames **Sync every** to **Reconcile every** and explains that configuration changes are event-driven rather than waiting for the reconciliation interval.
- Keeps text already entered in the **Add new integration** search field when integration discovery finishes after the user has started typing.
- Fixes official Home Assistant integration installation on Home Assistant OS hosts where nested Docker is unavailable by using Unfolded Circle's official architecture-specific release binary in UCVR's supervised process runtime.
- Uses the official Linux-x64 Home Assistant integration artifact on AMD64 and the official UCR2 artifact on ARM64; no Rust compiler or nested Docker is required for this fallback.
- Generates a per-instance integration listener configuration so the supervised Home Assistant integration uses UCVR's assigned port instead of colliding on its default port 8000.

## 0.14.15

- Version mirrored from UC Virtual Remote 0.14.15.
- Fixes Sync Mode enablement on Home Assistant OS when nested Docker is unavailable instead of failing with **“This installation source requires Docker, but nested Docker is unavailable on this host.”**
- Sync Mode now requests **Automatic** installation for Remote Sync rather than forcing the prebuilt container-image path.
- Registers and retains the `uc-remote-sync` GitHub source repository so HAOS can use UC Virtual Remote's supervised Node.js source-process runtime when Docker cannot run.
- Docker-capable installations can continue using the prebuilt GHCR image automatically; the fallback changes only the runtime selection required on restricted hosts.
- Custom GHCR integration definitions can now retain and persist an optional GitHub source repository for Automatic source fallback and update checks.

## 0.14.14

- Version mirrored from UC Virtual Remote 0.14.14.
- Fixes `401 Unauthorized` responses when mobile apps and other external clients render Core resource files such as icons and background images without propagating their API authorization header to the image request.
- Supports the physical-Core resource download forms `/resources/:type/:id` and `/api/resources/:type/:id` by routing binary `GET` requests to UC Virtual Remote's existing immutable public resource endpoint.
- Normalizes official `Icon` and `BackgroundImage` resource type names to the virtual remote's internal resource types.
- Keeps resource listing, upload, deletion and all other Core/Management operations behind their existing authentication requirements.
- External tools should address the virtual remote directly on the Home Assistant host network/UC Virtual Remote port rather than treating the Home Assistant Ingress URL as a device API endpoint.

## 0.14.13

- Version mirrored from UC Virtual Remote 0.14.13.
- Removes the Web Configurator login-screen prompt **“Looking for API definitions? Click here”** because those API-definition resources are not available on UC Virtual Remote.
- Keeps the login and authentication flow unchanged; only the unavailable prompt is removed.

## 0.14.12

- Version mirrored from UC Virtual Remote 0.14.12.
- Makes Home Assistant Supervisor authoritative for UC Virtual Remote add-on updates, preventing the Core application version from advancing independently of the installed add-on version.
- The Web Configurator and Management software-update interfaces keep their existing workflow, but Home Assistant installations now delegate the final add-on update to Supervisor instead of extracting a second application release into persistent `/data`.
- Enables Supervisor API access for the add-on so update checks use Home Assistant's installed/latest add-on versions and update installation targets the complete add-on package.
- Removes the legacy `/data/application/active.json` selector on add-on startup, repairing existing installations where the in-app updater previously created a version mismatch without deleting user configuration, integrations, resources or other persistent data.
- Standalone Docker installations keep the existing UC Virtual Remote GitHub-based internal updater unchanged.

## 0.14.11

- Version mirrored automatically from UC Virtual Remote 0.14.11.

## 0.14.10

- Version mirrored from UC Virtual Remote 0.14.10.
- Fixes registry-backed Python integrations such as Spotify on restricted Home Assistant OS hosts by launching package entry points with `python -m <package>` when a package exposes `__main__.py`, instead of executing an internal implementation `driver.py` file.
- Keeps explicit Python entrypoint overrides authoritative and adds the source checkout root to `PYTHONPATH` for integrations that intentionally run a script directly.
- Fixes ARM64 PyInstaller custom-integration tarballs that resolve `driver.json` relative to `bin/driver` by exposing the package-root manifest beside the runtime executable without overwriting package-supplied data.
- Fixes Spotify installation from both the integration registry and its ARM64 tarball on AMD64 Home Assistant hosts.

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
