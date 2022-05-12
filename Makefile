.PHONY: build
build:
	nerdctl build -t naegleria .

.PHONY: run
run:
	nerdctl run -it naegleria

.PHONY: assemble
assemble:
	nerdctl build -t naegleria-assemble -f Dockerfile.assemble .
	nerdctl run naegleria-assemble > main.s
