#include <stdio.h>

int fib(int n) {
    if(n == 0) {
        return 0;
    }
    else if(n == 1) {
        return 1;
    }
    else {
        return fib(n-1) + fib(n-2);
    }
}

int main(int argc, char *argv[]) {
    printf("%d\n", fib(10));
    return 0;
}

