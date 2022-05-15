#include <stdio.h>
#include <stdlib.h>

int tape[5000];
int *i;

int main() {
  system("stty -icanon");
  i = &tape;
  i++;
  //i--;
  (*i)++;
  //(*i)--;
  //putchar(*i);
  //*i = getchar();
  while (*i) {
    i++;
  }
  return 0;
}
