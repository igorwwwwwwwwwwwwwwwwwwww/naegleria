# RP2350 (RISC-V)

## Setup

```sh
(cd examples/rp2350 && ./fetch-deps.sh)
source examples/rp2350/deps/env.sh
```

## Build + flash (default `examples/hello.b`)

```sh
cmake -S examples/rp2350 -B examples/rp2350/build-riscv -DPICO_BOARD=pico2 -DPICO_PLATFORM=rp2350-riscv
cmake --build examples/rp2350/build-riscv -j
cmake --build examples/rp2350/build-riscv --target flash
```

## `cat.b` (stdin/stdout + newline mapping)

```sh
cmake -S examples/rp2350 -B examples/rp2350/build-riscv -DPICO_BOARD=pico2 -DPICO_PLATFORM=rp2350-riscv -DBF_SOURCE=$(pwd)/examples/cat.b
cmake --build examples/rp2350/build-riscv -j
cmake --build examples/rp2350/build-riscv --target flash
picocom -b 115200 --imap lfcrlf --omap crcrlf /dev/cu.usbmodem1101
```

## `mandelbrot.b` (timed)

```sh
cmake -S examples/rp2350 -B examples/rp2350/build-riscv -DPICO_BOARD=pico2 -DPICO_PLATFORM=rp2350-riscv -DBF_ENABLE_TIMING=ON -DBF_SOURCE=$(pwd)/examples/mandelbrot.b
cmake --build examples/rp2350/build-riscv -j
cmake --build examples/rp2350/build-riscv --target flash
picocom -b 115200 --imap lfcrlf /dev/cu.usbmodem1101
```

## USB serial

```sh
ls /dev/cu.usbmodem*
picocom -b 115200 --imap lfcrlf /dev/cu.usbmodem1101
```

## GDB (RP OpenOCD + RISC-V gdb)

```sh
cd ../openocd
./src/openocd -s tcl -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg
```

```sh
examples/rp2350/deps/riscv-toolchain/bin/riscv32-unknown-elf-gdb -q \
  -ex "file $(pwd)/examples/rp2350/build-riscv/naegleria_rp2350.elf" \
  -ex "target extended-remote :3333" \
  -ex "monitor reset halt" \
  -ex "thbreak main"
```
