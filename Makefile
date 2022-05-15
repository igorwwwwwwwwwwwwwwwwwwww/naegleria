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

.PHONY: llvm
llvm:
	nerdctl build -t naegleria-llvm -f Dockerfile.llvm .
	nerdctl run -it naegleria-llvm

.PHONY: wasm
wasm:
	nerdctl build -t naegleria-wasm -f Dockerfile.wasm .
	nerdctl run -it naegleria-wasm
