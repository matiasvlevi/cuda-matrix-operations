#include "matrix/matrix.cuh"

int main() {

	int N = 3; // A matrix columns and B matrix rows
	int M = 2; // A matrix rows
	int P = 4; // B matrix columns

	float a[M*N];
	matrix::init(a, M, N);

	float b[P*N];
	matrix::init(b, N, P);

	float c[P*M];
	matrix::init(c, M, P);

	float *cudaA = 0;
	float *cudaB = 0;
	float *cudaC = 0;

	std::cout << "Start" << std::endl;
	
	matrix::log(a, M, N, 'A');
	matrix::log(b, N, P, 'B');
 	
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
	
	matrix::dot<<<BLOCKS, THREADS>>>(cudaA, cudaB, cudaC, N, M, P);
 
	cudaMemcpy(c, cudaC, sizeof(c), cudaMemcpyDeviceToHost);
 	
 	cudaFree(cudaA);
 	cudaFree(cudaB);
 	cudaFree(cudaC);
 
 	matrix::log(c, M, P, 'C');

	std::cout << "Finished" << std::endl;

	return 0;
}
