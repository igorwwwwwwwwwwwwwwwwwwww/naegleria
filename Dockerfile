FROM gcc:10
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
# RUN gcc -o myapp main.c
# CMD ["./myapp"]
# RUN gcc -S main.c
RUN gcc -g -S -O3 -g0 main.c
CMD ["cat", "main.s"]
