# RP2350 (RISC-V) build

This example builds a UF2 for RP2350 using the `riscv` backend and Pico SDK.

## Prerequisites

- `php`
- `git`, `curl`, and `unzip` (used by `fetch-deps.sh`)
- `cmake` and a build tool generator (`ninja` or `make`)
- `picotool` (optional, for flashing via command line and `flash` target)

Quick setup for Pico SDK:

```sh
cd examples/rp2350
./fetch-deps.sh
source ./deps/env.sh
```

## Configure and build

```sh
cd examples/rp2350
mkdir -p build
cd build
cmake -DPICO_BOARD=pico2 -DPICO_PLATFORM=rp2350-riscv ..
cmake --build . -j
```

If you change `PICO_PLATFORM`, toolchain settings, or `PICO_TOOLCHAIN_PATH`, use a fresh build directory (or delete `CMakeCache.txt`) before re-running `cmake`.

By default this compiles `examples/hello.b`.

To compile a different Brainfuck source:

```sh
cmake -DPICO_BOARD=pico2 -DPICO_PLATFORM=rp2350-riscv -DBF_SOURCE=/absolute/path/to/program.b ..
cmake --build . -j
```

## Flash

The UF2 file is generated at:

`examples/rp2350/build/naegleria_rp2350.uf2`

Put the board in BOOTSEL mode and copy the UF2 to the mounted drive.

If `picotool` is installed, you can flash directly from the build dir:

```sh
cmake --build . --target flash
```

If `flash` target is missing, install `picotool` or flash the generated UF2 manually in BOOTSEL mode.

## Serial output (UART/USB)

This example enables both USB CDC stdio and UART stdio.

USB serial on macOS (example):

```sh
ls /dev/cu.usbmodem*
picocom -b 115200 --imap lfcrlf /dev/cu.usbmodem1101
```

Open the serial terminal before pressing reset/flashing, otherwise short-lived output (for example `Hello World!`) can be missed.

For physical UART pins, connect a 3.3V USB-UART adapter to the board UART TX/RX/GND and use 115200 baud, 8N1.
