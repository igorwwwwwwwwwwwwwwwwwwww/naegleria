# Naegleria

A [brainfuck](http://esolangs.org/wiki/Brainfuck) compiler written in PHP.

![](doc/naegleria.png)

> Naegleria fowleri /nəˈɡlɪəriə/ (also known as the "brain-eating amoeba") infects people by entering the body through the nose.

## Usage

You can use Naegleria to compile a brainfuck file into AT&T assembly. This can then be assembled using `gcc`, and executed directly.

    $ bin/compile $(uname -m) examples/hello.b > hello.s
    $ gcc -o hello hello.s
    $ ./hello
    Hello World!

For more cross-platform support, you can use the LLVM backend:

    $ bin/compile llvm examples/hello.b > hello.ll
    $ clang -o hello hello.ll
    $ ./hello
    Hello World!

## Platforms

- linux amd64
- linux aarch64
- riscv (RV32 assembly, suitable for RP2350 Pico SDK integration)
- llvm
- php (source)
- wasm (with WASI)

## RP2350 (RISC-V)

Use the `riscv` backend to generate RV32 assembly:

    $ bin/compile riscv examples/hello.b > hello-riscv.S

For a complete RP2350 UF2 flow, see `examples/rp2350`.

## Limitations

The compiler uses a fixed-size array of 4000 elements for the cells. Good luck!

## Performance

It's assembly, so probably faster than C.

## Benchmarks

Run your own.

## Optimizations

This is not (yet) an optimizing compiler.

## TODO

- Rename `aarch64` target to `arm64` (keep `aarch64` as a compatibility alias).

## Acknowledgements

* Thanks to [@nikita_ppv](https://twitter.com/nikita_ppv) for planting the idea a long time ago.
* Thanks to [@codeoracle](https://twitter.com/codeoracle) for the inspiration to pick up `gcc -S`.
* Thanks to [@dazzlog](https://twitter.com/dazzlog) for helping understand assembly.
* Thanks to [@old_sound](https://twitter.com/old_sound) for coming up with the name and logo.
* Thanks to [the Esolang wiki](http://esolangs.org/) for being a great resource.
