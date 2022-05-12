FROM gcc:10
RUN mkdir /usr/src/myapp
COPY main.c /usr/src/myapp
WORKDIR /usr/src/myapp
RUN gcc -g -S -O1 -g0 main.c
CMD ["cat", "main.s"]
