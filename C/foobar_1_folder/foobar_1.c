#include <stdio.h>

int main(int argc, char *argv[]) {
    for (int i = 1; i < 21; i++) {
        printf("%d", i);
        if (i%3 == 0){
            printf("foo");
        }
        if(i%5 == 0){
            printf("bar");
        }
        printf("\n");
    }
    return 0;
}