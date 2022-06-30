#include <iostream>

namespace matrix {
    __global__ void dot(
        float *a,
        float *b,
        float *c,
        int N,
        int M,
        int P
    );
    __global__ void add(
        float *a,
        float *b,
        float *c,
        int R,
        int C
    );
    void init(float* m, int R, int C);
    void log(float* m, int R, int C, char name);
}
