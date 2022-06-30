#include "../matrix/matrix.cuh"

int main() {

	int N = 8; // matrix rows
	int M = 8; // matrix cols

	float a[M*N];
	matrix::init(a, M, N);

	float b[M*N];
	matrix::init(b, M, N);

	float c[M*N];
	matrix::init(c, M, N);

	float *cudaA = 0;
	float *cudaB = 0;
	float *cudaC = 0;

	std::cout << "Start" << std::endl;
	
	matrix::log(a, M, N, 'A');
	matrix::log(b, M, N, 'B');
 	
	cudaMalloc(&cudaA, sizeof(a));
 	cudaMalloc(&cudaB, sizeof(b));
 	cudaMalloc(&cudaC, sizeof(c));
 
 	cudaMemcpy(cudaA, a, sizeof(a), cudaMemcpyHostToDevice);
 	cudaMemcpy(cudaB, b, sizeof(b), cudaMemcpyHostToDevice);
 	cudaMemcpy(cudaC, c, sizeof(c), cudaMemcpyHostToDevice);
 
 	dim3 THREADS;
 	THREADS.x = 16;
 	THREADS.y = 16;
 
 	int blocks = (N + THREADS.x - 1) / THREADS.x;
 
 	dim3 BLOCKS;
 	BLOCKS.x = blocks;
 	BLOCKS.y = blocks;
	
	matrix::add<<<BLOCKS, THREADS>>>(cudaA, cudaB, cudaC, N, M);
 
	cudaMemcpy(c, cudaC, sizeof(c), cudaMemcpyDeviceToHost);
 	
 	cudaFree(cudaA);
 	cudaFree(cudaB);
 	cudaFree(cudaC);
 
 	matrix::log(c, M, N, 'C');

	std::cout << "Finished" << std::endl;

	return 0;
}
