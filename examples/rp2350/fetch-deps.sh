#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPS_DIR="${SCRIPT_DIR}/deps"
PICO_SDK_DIR="${DEPS_DIR}/pico-sdk"
PICO_SDK_REF="${PICO_SDK_REF:-master}"
PICO_SDK_TOOLS_TAG="${PICO_SDK_TOOLS_TAG:-v2.0.0-5}"
RISCV_TOOLCHAIN_HINT_DIR="${DEPS_DIR}/riscv-toolchain"

mkdir -p "${DEPS_DIR}"

if [[ -d "${PICO_SDK_DIR}/.git" ]]; then
  echo "Updating pico-sdk in ${PICO_SDK_DIR}"
  git -C "${PICO_SDK_DIR}" fetch --depth=1 origin "${PICO_SDK_REF}"
  git -C "${PICO_SDK_DIR}" checkout -q FETCH_HEAD
else
  echo "Cloning pico-sdk into ${PICO_SDK_DIR}"
  git clone --depth=1 --branch "${PICO_SDK_REF}" https://github.com/raspberrypi/pico-sdk.git "${PICO_SDK_DIR}"
fi

echo "Initializing pico-sdk submodules"
git -C "${PICO_SDK_DIR}" submodule update --init --depth=1

find_riscv_toolchain_bin() {
  find "${DEPS_DIR}" -maxdepth 6 -type f \
    \( -name "riscv32-unknown-elf-gcc" -o -name "riscv32-corev-elf-gcc" \) \
    | head -n 1
}

TOOLCHAIN_GCC="$(find_riscv_toolchain_bin || true)"
if [[ -z "${TOOLCHAIN_GCC}" || "${FORCE_TOOLCHAIN:-0}" == "1" ]]; then
  os="$(uname -s)"
  arch="$(uname -m)"
  case "${os}:${arch}" in
    Darwin:arm64)
      archive_name="riscv-toolchain-14-arm64-mac.zip"
      ;;
    Darwin:x86_64)
      archive_name="riscv-toolchain-14-x64-mac.zip"
      ;;
    Linux:aarch64|Linux:arm64)
      archive_name="riscv-toolchain-14-aarch64-lin.tar.gz"
      ;;
    Linux:x86_64)
      archive_name="riscv-toolchain-14-x86_64-lin.tar.gz"
      ;;
    *)
      echo "Unsupported host for automatic RISC-V toolchain download: ${os}:${arch}" >&2
      exit 1
      ;;
  esac

  url="https://github.com/raspberrypi/pico-sdk-tools/releases/download/${PICO_SDK_TOOLS_TAG}/${archive_name}"
  archive_path="${DEPS_DIR}/${archive_name}"

  echo "Downloading ${archive_name}"
  curl -fL --retry 3 -o "${archive_path}" "${url}"

  rm -rf "${RISCV_TOOLCHAIN_HINT_DIR}"
  mkdir -p "${RISCV_TOOLCHAIN_HINT_DIR}"

  echo "Extracting toolchain to ${RISCV_TOOLCHAIN_HINT_DIR}"
  case "${archive_name}" in
    *.zip)
      unzip -q -o "${archive_path}" -d "${RISCV_TOOLCHAIN_HINT_DIR}"
      ;;
    *.tar.gz)
      tar -xzf "${archive_path}" -C "${RISCV_TOOLCHAIN_HINT_DIR}"
      ;;
  esac

  TOOLCHAIN_GCC="$(find_riscv_toolchain_bin || true)"
  if [[ -z "${TOOLCHAIN_GCC}" ]]; then
    echo "Failed to locate riscv32 toolchain binaries after extraction" >&2
    exit 1
  fi
else
  echo "RISC-V toolchain already present at ${TOOLCHAIN_GCC}"
fi

TOOLCHAIN_ROOT="$(cd "$(dirname "${TOOLCHAIN_GCC}")/.." && pwd)"
ENV_FILE="${DEPS_DIR}/env.sh"

cat > "${ENV_FILE}" <<EOF
export PICO_SDK_PATH="${PICO_SDK_DIR}"
export PICO_TOOLCHAIN_PATH="${TOOLCHAIN_ROOT}"
EOF

cat <<EOF
Done.
Set:
  export PICO_SDK_PATH="${PICO_SDK_DIR}"
  export PICO_TOOLCHAIN_PATH="${TOOLCHAIN_ROOT}"
Or source:
  source "${ENV_FILE}"
EOF
