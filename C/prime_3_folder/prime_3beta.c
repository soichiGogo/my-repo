#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("使用方法: %s <数値>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);
    int arr[n];
    for (int i = 0; i < n; i++) {
        arr[i] = 0;
    }
    if (n == 1){
        arr[0] = 2;
    }
    else if (n == 2){
        arr[0]=2;
        arr[1]=3;
    }
    else if (n == 3){
        arr[0]=2;
        arr[1]=3;
        arr[2]=5;
    }
    else{
        arr[0]=2;
        arr[1]=3;
        arr[2]=5;
        arr[3]=7;
    }
    
    int wheel[8] = {4, 2, 4, 2, 4, 6, 2, 6};
    int wheel_index = 0;
    
    for (int i = 4; i < n; i++){
        for (int m = arr[i-1]+wheel[wheel_index]; arr[i] == 0; m+=wheel[wheel_index]){
            int devisor = 0;
            while (arr[devisor] * arr[devisor] <= m){
                if (m % arr[devisor]  == 0){
                    break;
                }
                devisor++;
            }
            if (arr[devisor] * arr[devisor] > m){
                arr[i] = m;
            }
            wheel_index = (wheel_index + 1) % 8;
        }
    }
    
    int result = printf("%d\n", arr[n-1]);
    return 0;
}

//工夫1: Nを素数判定する際に、Nの平方根以下の数で割り切れるかどうかを調べる。
//工夫2: Nの平方根以下の数で割り切れるか調べる際は、数Nの平方根以下の数のうち、素数のみを調べる。
//工夫3: Wheel factorizationを用いることで2,3,5の倍数を除いた数のみを調べる。

