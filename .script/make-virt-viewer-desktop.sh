#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  make-virt-viewer-desktop.sh <vm_name> [output_path]
  make-virt-viewer-desktop.sh --install <vm_name>
  make-virt-viewer-desktop.sh --list

Creates a virt-viewer .desktop file from the template in this directory.

Environment overrides:
  GDK_BACKEND (default: wayland)
  ICON_NAME   (default: virt-viewer)

Examples:
  make-virt-viewer-desktop.sh win11
  make-virt-viewer-desktop.sh --install win11
  make-virt-viewer-desktop.sh --list
  ICON_NAME=computer GDK_BACKEND=x11 make-virt-viewer-desktop.sh "My VM" ~/Desktop/virt-viewer-MyVM.desktop
USAGE
}

if [[ ${1-} == "" || ${1-} == "-h" || ${1-} == "--help" ]]; then
  usage
  exit 0
fi

if [[ ${1-} == "--list" ]]; then
  if ! command -v virsh >/dev/null 2>&1; then
    echo "virsh not found in PATH." >&2
    exit 1
  fi
  # List all defined VM names.
  virsh --connect qemu:///system list --all --name | sed '/^$/d'
  exit 0
fi

install_mode="false"
if [[ ${1-} == "--install" ]]; then
  install_mode="true"
  shift
fi

if [[ ${1-} == "" ]]; then
  usage
  exit 1
fi

vm_name="$1"
output_path="${2-}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
template="${script_dir}/virt-viewer-VMNAME.desktop"

if [[ ! -f "$template" ]]; then
  echo "Template not found: $template" >&2
  exit 1
fi

GDK_BACKEND="${GDK_BACKEND:-wayland}"
ICON_NAME="${ICON_NAME:-virt-viewer}"

if [[ -z "$output_path" ]]; then
  safe_vm_name="${vm_name// /}"
  if [[ "$install_mode" == "true" ]]; then
    output_path="${HOME}/.local/share/applications/virt-viewer-${safe_vm_name}.desktop"
  else
    output_path="${script_dir}/virt-viewer-${safe_vm_name}.desktop"
  fi
fi

# Replace variables in the template.
sed \
  -e "s|\${VM_NAME}|${vm_name}|g" \
  -e "s|\${GDK_BACKEND}|${GDK_BACKEND}|g" \
  -e "s|\${ICON_NAME}|${ICON_NAME}|g" \
  "$template" > "$output_path"

chmod +x "$output_path"

if command -v update-desktop-database >/dev/null 2>&1; then
  output_dir="$(dirname "$output_path")"
  update-desktop-database "$output_dir" >/dev/null 2>&1 || true
else
  echo "Note: update-desktop-database not found; skipping desktop database refresh." >&2
fi

echo "Wrote: $output_path"
