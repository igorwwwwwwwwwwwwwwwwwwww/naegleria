#include <stdlib.h>

int tape[5000];
int i = 0;

int main() {
  system("stty -icanon");
  while (!tape[i]) {
    i++;
  }
  putchar(i);
  return 0;
}
