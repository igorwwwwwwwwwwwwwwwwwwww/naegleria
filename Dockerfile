FROM php:8.1-cli
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN bin/compile $(uname -m) examples/hello.b > main.s

FROM gcc:10
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
COPY --from=0 /usr/src/myapp/main.s .
RUN gcc -c main.s -o myapp.o
RUN gcc myapp.o -o myapp
CMD ["./myapp"]
