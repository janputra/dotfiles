#!/usr/bin/env bash
set -euo pipefail

# Edit this list when you want to add/remove dconf paths.
# Format: "<dconf path>|<relative output file>"
SETTINGS_MAP=(
  "/org/gnome/desktop/wm/|desktop/wm.dconf"
  "/org/gnome/desktop/interface/|desktop/interface.dconf"
  "/org/gnome/mutter/|mutter/mutter.dconf"
  "/org/gnome/settings-daemon/plugins/media-keys/|settings-daemon/media-keys.dconf"
  "/org/gnome/shell/|shell/shell.dconf"
)

BASE_DIR="${2:-gnome_settings}"

usage() {
  echo "Usage: $0 [export|import] [settings_dir]"
}

export_settings() {
  local entry path rel_file out_file

  for entry in "${SETTINGS_MAP[@]}"; do
    path="${entry%%|*}"
    rel_file="${entry#*|}"
    out_file="${BASE_DIR}/${rel_file}"

    mkdir -p "$(dirname "${out_file}")"
    dconf dump "${path}" > "${out_file}"
    echo "Exported ${path} -> ${out_file}"
  done
}

import_settings() {
  local entry path rel_file in_file

  for entry in "${SETTINGS_MAP[@]}"; do
    path="${entry%%|*}"
    rel_file="${entry#*|}"
    in_file="${BASE_DIR}/${rel_file}"

    if [[ ! -f "${in_file}" ]]; then
      echo "Skipping ${path}: file not found (${in_file})"
      continue
    fi

    dconf load "${path}" < "${in_file}"
    echo "Imported ${in_file} -> ${path}"
  done
}

case "${1:-}" in
  export)
    export_settings
    ;;
  import)
    import_settings
    ;;
  *)
    usage
    exit 1
    ;;
esac
