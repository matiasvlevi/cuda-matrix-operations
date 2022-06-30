#include "matrix.cuh"

/**
* transpose
* 
* transpose a matrix
*/
__global__ void matrix::transpose(
    float *a,
    float *c,
    int R,
    int C
) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    // Abort if out of range
    if (row >= R || col >= C) return; 

    c[col * R + row] = a[row * C + col];
}