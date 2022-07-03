#include "../matrix.cuh"

__global__
void Kernel::map(
	float *a,
	float *c,
	int N,
	int M,
	mathFunc operation
) {
	
	int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;	

	// Abort if out of range
	if (row >= N || col >= M) return;

	c[row * M + col] = Activation::sigmoid(a[row * M + col]); 

}	
