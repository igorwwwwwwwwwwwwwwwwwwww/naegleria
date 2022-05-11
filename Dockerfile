FROM gcc:10
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

RUN gcc -c hello.s -o myapp.o
RUN gcc myapp.o -o myapp
CMD ["./myapp"]
# RUN gcc -S main.c
# RUN gcc -g -S -O0 -g0 main.c
# CMD ["cat", "main.s"]
