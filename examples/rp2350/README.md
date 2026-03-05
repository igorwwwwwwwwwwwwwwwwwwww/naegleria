# RP2350 (RISC-V)

Build and flash Brainfuck programs on Pico 2 (RP2350 RISC-V core).

## Requirements

- `php`
- `git`, `curl`, `unzip`
- `cmake` + `ninja` (or `make`)
- `picotool` (optional, for CLI flashing)

## Setup

```sh
cd examples/rp2350
./fetch-deps.sh
source ./deps/env.sh
```

One-liner (setup + build + flash):

```sh
(cd examples/rp2350 && ./fetch-deps.sh && source ./deps/env.sh && rm -rf build-riscv && cmake -S . -B build-riscv -DPICO_BOARD=pico2 -DPICO_PLATFORM=rp2350-riscv && cmake --build build-riscv -j && cmake --build build-riscv --target flash)
```

## Build

```sh
mkdir -p build && cd build
cmake -DPICO_BOARD=pico2 -DPICO_PLATFORM=rp2350-riscv ..
cmake --build . -j
```

Default BF source is `examples/hello.b`.

Use a different source:

```sh
cmake -DPICO_BOARD=pico2 -DPICO_PLATFORM=rp2350-riscv -DBF_SOURCE=/absolute/path/to/program.b ..
cmake --build . -j
```

If you change toolchain/platform settings, use a fresh build dir.

## Flash

UF2 output:
`examples/rp2350/build/naegleria_rp2350.uf2`

Manual: copy UF2 in BOOTSEL mode.  
CLI (if `picotool` is installed):

```sh
cmake --build . --target flash
```

## Serial

USB serial on macOS:

```sh
ls /dev/cu.usbmodem*
picocom -b 115200 --imap lfcrlf /dev/cu.usbmodem1101
```

Open serial before reset/flash, otherwise short output can be missed.

Hardware UART also works at `115200 8N1` (3.3V USB-UART adapter, TX/RX/GND).
