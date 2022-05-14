.PHONY: build
build:
	nerdctl build -t naegleria .

.PHONY: run
run:
	nerdctl run -it naegleria

.PHONY: asm
asm:
	nerdctl build -t naegleria-asm -f Dockerfile.asm .
	nerdctl run naegleria-asm > main.s

.PHONY: wasm
wasm:
	bin/compile examples/hello\ copy.b > hello.wat && wat2wasm --debug-names hello.wat && wasmtime run -g hello.wasm

.PHONY: wasm-debug
wasm-debug:
	bin/compile examples/hello\ copy.b > hello.wat && wat2wasm --debug-names hello.wat && lldebug -- wasmtime run -g hello.wasm
