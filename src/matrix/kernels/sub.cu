#include "../matrix.cuh"

/**
* sub
* 
* Subtract 2 matrices with the same dimension
*
*/
__global__ void Kernel::sub(
    float *a,
    float *b,
    float *c,
    int R,
    int C
) {

    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;	

    // Abort if out of range
    if (row >= R || col >= C) return;

    c[row * C + col] = a[row * C + col] - b[row * C + col];

    return;
}