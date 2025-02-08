#include <stdio.h>

int main(int argc, char *argv[]) {
    int f0 = 0;
    int f1 = 1;
    int fn_2 = f0;
    int fn_1 = f1;
    for (int i = 2; i < 11; i++){
        int fn = fn_1 + fn_2;
        fn_2 = fn_1;
        fn_1 = fn;
        printf("f%d = %d\n", i, fn);
    }
    
}