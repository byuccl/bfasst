#!/usr/bin/env bash
set -euo pipefail

CMAKE_VERSION="$1"
BASE="$(cd "$(dirname "$0")/.." && pwd)"
DIST_DIR="$BASE/third_party/cmake"
DIR_NAME="cmake-${CMAKE_VERSION}-linux-x86_64"
TARBALL="${DIR_NAME}.tar.gz"
URL="https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${TARBALL}"

MARKER_START="### CMAKE PATH HOOK START ###"
MARKER_END="### CMAKE PATH HOOK END ###"

echo "Installing CMake ${CMAKE_VERSION}…"

mkdir -p "${DIST_DIR}"
if [ ! -d "${DIST_DIR}/${DIR_NAME}" ]; then
  curl -Ls "${URL}" | tar -xz -C "${DIST_DIR}"
else
  echo "CMake ${CMAKE_VERSION} already present."
fi

_update_hook() {
  local hookfile=$1; shift
  local block="$@"
  if [ -f "${hookfile}" ]; then
    sed -i "/${MARKER_START}/,/${MARKER_END}/d" "${hookfile}"
    {
      echo ""
      echo "${MARKER_START}"
      echo "${block}"
      echo "${MARKER_END}"
    } >> "${hookfile}"
  fi
}

activate_block=$(
  cat <<EOF
export _OLD_PATH="\\\$PATH"
export PATH="${DIST_DIR}/${DIR_NAME}/bin:\$PATH"
EOF
)

deactivate_block=$(
  cat <<EOF
export PATH="\$_OLD_PATH"
unset _OLD_PATH
EOF
)

_update_hook ".venv/bin/activate"   "${activate_block}"
_update_hook ".venv/bin/deactivate"  "${deactivate_block}"

echo "Done installing CMake ${CMAKE_VERSION}."
