FROM php:7.4-cli
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN bin/compile examples/hello.b > main.s

FROM gcc:10
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
COPY --from=0 /usr/src/myapp/main.s .
RUN gcc -c main.s -o myapp.o
RUN gcc myapp.o -o myapp
CMD ["./myapp"]

# RUN gcc -g -S -O0 -g0 main.c
# CMD ["cat", "main.s"]
