#include <iostream>

#ifdef __CUDACC__
#define CUDA_CALLABLE_MEMBER __host__ __global__ __global__
#else
#define CUDA_CALLABLE_MEMBER
#endif 

#ifndef KERNEL_H
#define KERNEL_H 
namespace Kernel {
    // Kernel functions
    __global__ void dot(float *a, float *b, float *c, int N, int M, int P);
    __global__ void add(float *a, float *b, float *c, int R, int C);
    __global__ void sub(float *a, float *b, float *c, int R, int C);
    __global__ void transpose(float *a, float *c, int R, int C);
}
#endif

#ifndef MATRIX_H
#define MATRIX_H
class Matrix {
public:
    float* values;
    int rows;
    int cols;

    Matrix(float* m_values, int m_rows, int m_cols) {
        values = m_values;
        rows = m_rows;
        cols = m_cols;
    }

    // Utility functions
    void init();
    void initRandomi();
    void initRandomf();

    static void init_static(float* m, int R, int C);
    static void initRandomi_static(float* m, int R, int C);
    static void initRandomf_static(float* m, int R, int C);
    
    static void log_static(float* m, int R, int C, char name = 'M');
    void log(char name = 'M');
};
#endif
