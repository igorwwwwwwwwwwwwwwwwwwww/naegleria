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

For `cat.b` echo tests, use output mapping too so Enter behaves like a newline:

```sh
picocom -b 115200 --imap lfcrlf --omap crcrlf /dev/cu.usbmodem1101
```

## Debug (OpenOCD + GDB)

Use an OpenOCD build with RP2350 support (for example Raspberry Pi OpenOCD).
Homebrew OpenOCD may only ship `rp2040` target scripts.

Start OpenOCD (example using a local `../openocd` clone):

```sh
cd ../openocd
./src/openocd -s tcl -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg
```

In another terminal, start RISC-V GDB (not `arm-none-eabi-gdb`):

```sh
examples/rp2350/deps/riscv-toolchain/bin/riscv32-unknown-elf-gdb -q \
  -ex "file /Users/igor/code/naegleria/examples/rp2350/build-riscv/naegleria_rp2350.elf" \
  -ex "target extended-remote :3333" \
  -ex "monitor reset halt" \
  -ex "thbreak main"
```

Useful commands:

```gdb
continue
bt
info reg
```

If GDB stops in `_exit`, that usually means the program ended normally.
