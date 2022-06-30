#include "../matrix/matrix.cuh"


int main() {

	int N = 8; // matrix cols
	int M = 6; // matrix rows

	float a[M*N];
	matrix::init(a, N, M);

	float c[N*M];
	matrix::init(c, M, N);

	float *cudaA = 0;
	float *cudaC = 0;

	std::cout << "Start" << std::endl;
	
	matrix::log(a, N, M, 'A');
 	
	cudaMalloc(&cudaA, sizeof(a));
 	cudaMalloc(&cudaC, sizeof(c));
 
 	cudaMemcpy(cudaA, a, sizeof(a), cudaMemcpyHostToDevice);
 	cudaMemcpy(cudaC, c, sizeof(c), cudaMemcpyHostToDevice);
 
 	dim3 THREADS;
 	THREADS.x = 16;
 	THREADS.y = 16;
 
 	int blocks = (N + THREADS.x - 1) / THREADS.x;
 
 	dim3 BLOCKS;
 	BLOCKS.x = blocks;
 	BLOCKS.y = blocks;
	
	matrix::transpose<<<BLOCKS, THREADS>>>(cudaA, cudaC, N, M);
 
	cudaMemcpy(c, cudaC, sizeof(c), cudaMemcpyDeviceToHost);
 	
 	cudaFree(cudaA);
 	cudaFree(cudaC);
 
 	matrix::log(c, M, N, 'C');

	std::cout << "Finished" << std::endl;

	return 0;
}
