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
    arr[0]=2;
    
    
    for (int i = 1; i < n; i++){
        for (int m = arr[i-1]+1; arr[i] == 0; m++){
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
            
        }
    }
    
    int result = printf("%d\n", arr[n-1]);
    return 0;
}