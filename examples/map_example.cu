#include "../src/matrix/matrix.cuh"

int main() {
	int N = 6; // A matrix columns
	int M = 6; // A matrix rows

	float a[M*N];
	Matrix::initRandomi_static(a, M, N);

	float c[M*N];
	Matrix::init_static(c, M, N);

	Matrix::log_static(a, M, N, 'A');
	Matrix::log_static(c, M, N, 'C');

	float *cudaA = 0;
	float *cudaC = 0;

	cudaMalloc(&cudaA, sizeof(a));
 	cudaMalloc(&cudaC, sizeof(c));
 
 	cudaMemcpy(cudaA, a, sizeof(a), cudaMemcpyHostToDevice);
 	cudaMemcpy(cudaC, c, sizeof(c), cudaMemcpyHostToDevice);
	
	mathFunc h_pointFunc;

	cudaError_t err = cudaMemcpyFromSymbol(&h_pointFunc, Activation::sigmoid, sizeof(mathFunc));
	
 	dim3 THREADS;
 	THREADS.x = 16;
 	THREADS.y = 16;
 
 	int blocks = (N + THREADS.x - 1) / THREADS.x;
 
 	dim3 BLOCKS;
 	BLOCKS.x = blocks;
 	BLOCKS.y = blocks;
	
	std::cout << "Start" << std::endl;
	
	Kernel::map<<<BLOCKS, THREADS>>>(cudaA, cudaC, M, N, h_pointFunc);
	
	cudaMemcpy(c, cudaC, sizeof(c), cudaMemcpyDeviceToHost);
 	
 	cudaFree(cudaA);
 	cudaFree(cudaC);

 	Matrix::log_static(c, M, N, 'C');

	std::cout << "Finished" << std::endl;

	return 0;
}
