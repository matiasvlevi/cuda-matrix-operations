#include "../src/matrix/matrix.cuh"

int main() {

	int N = 2; // A matrix columns and B matrix rows
	int M = 3; // A matrix rows
	int P = 1; // B matrix columns

	float a[M*N];
	Matrix::initRandomi_static(a, M, N);

	float b[P*N];
	Matrix::initRandomi_static(b, N, P);

	float c[P*M];
	Matrix::initRandomi_static(c, M, P);

	Matrix::log_static(a, M, N, 'A');
	Matrix::log_static(b, N, P, 'B');

	float *cudaA = 0;
	float *cudaB = 0;
	float *cudaC = 0;

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
	
	std::cout << "Start" << std::endl;
	
	Kernel::dot<<<BLOCKS, THREADS>>>(cudaA, cudaB, cudaC, N, M, P);
 
	cudaMemcpy(c, cudaC, sizeof(c), cudaMemcpyDeviceToHost);
 	
 	cudaFree(cudaA);
 	cudaFree(cudaB);
 	cudaFree(cudaC);
 
 	Matrix::log_static(c, M, P, 'C');

	std::cout << "Finished" << std::endl;

	return 0;
}
