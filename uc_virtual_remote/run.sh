#!/usr/bin/env bash
set -euo pipefail

CONFIG_PATH=/data/options.json

while IFS= read -r -d '' assignment; do
  export "$assignment"
done < <(
  node - "$CONFIG_PATH" <<'NODE'
const fs = require("node:fs");
const file = process.argv[2];
let options = {};
try {
  options = JSON.parse(fs.readFileSync(file, "utf8"));
} catch {}

const values = {
  UCVR_PIN: options.pin ?? "1234",
  UCVR_NAME: options.remote_name ?? "Virtual Remote 3",
  LOG_LEVEL: options.log_level ?? "info",
  UCVR_DIND_STORAGE_DRIVER: options.dind_storage_driver ?? "overlay2",
};
if (options.github_token) values.UCVR_GITHUB_TOKEN = options.github_token;

for (const [key, value] of Object.entries(values)) {
  process.stdout.write(`${key}=${String(value)}\0`);
}
NODE
)

export UCVR_DATA_DIR=/data
export UCVR_HOST=0.0.0.0
export UCVR_REST_PORT=11090
export UCVR_INTEGRATION_PORT_START=11091
export UCVR_INTEGRATION_HOST=127.0.0.1
export UCVR_NATIVE_INTEGRATION_HOST=127.0.0.1
export UCVR_DIND=true
export UCVR_RUN_AS_ROOT=true
export UCVR_UPDATE_REPOSITORY=jstnjx/uc-virtual-remote-arm64
export UCVR_UPDATE_BRANCH=main
export UCVR_SUPERVISOR_MANAGED=true
export UCVR_SUPERVISOR_API_BASE=http://supervisor

LEGACY_ACTIVE_RELEASE=/data/application/active.json
if [[ -f "$LEGACY_ACTIVE_RELEASE" ]]; then
  echo "UC Virtual Remote: Home Assistant Supervisor manages add-on updates; removing legacy in-app active release selection."
  rm -f "$LEGACY_ACTIVE_RELEASE"
fi

exec /usr/local/bin/ucvr-entrypoint node /app/launcher.js
