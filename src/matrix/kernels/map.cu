#include "../matrix.cuh"

__global__
void Kernel::map(
	float *a,
	float *c,
	int M,
	mathFunc operation
) {
	
	int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;	

	c[row * M + col] = operation(a[row * M + col]); 

}
