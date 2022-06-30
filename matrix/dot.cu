#include "matrix.cuh"

/**
* Mult
* 
*  dot product
*/
__global__ void matrix::dot(
    float *a,
    float *b,
    float *c,
    int N,
    int M,
    int P
) {

    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;	

    // Abort if out of range
    if (row >= M || col >= P) return;

    float sum = 0;
    for (int k = 0; k < P; k++) {
        sum += a[row * N + k] * b[k * P + col];
    }

    c[row * P + col] = sum;

    return;
}