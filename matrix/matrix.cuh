#include <iostream>

namespace matrix {
    // Kernel functions
    __global__ void dot(float *a, float *b, float *c, int N, int M, int P);
    __global__ void add(float *a, float *b, float *c, int R, int C);
    __global__ void sub(float *a, float *b, float *c, int R, int C);
    __global__ void transpose(float *a, float *c, int R, int C);
    
    // Utility functions
    void init(float* m, int R, int C);
    void initRandom(float* m, int R, int C);
    void log(float* m, int R, int C, char name = 'M');
}
