FROM gcc:10
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
# RUN gcc -o myapp main.c
# CMD ["./myapp"]
# RUN gcc -S -masm=intel main.c
RUN gcc -g -S -O2 -masm=intel main.c
CMD ["cat", "main.s"]
