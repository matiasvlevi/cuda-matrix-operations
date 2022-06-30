#include <iostream>

/**
* matrixMult
* 
* Matrix dot product
*/
__global__ void matrixMult(float *a, float *b, float *c, int N, int M, int P) {

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

/**
* matrixAdd
* 
* Add 2 matrices with the same dimension
*
*/
__global__ void matrixAdd(float *a, float *b, float *c, int R, int C) {

	int row = blockIdx.y * blockDim.y + threadIdx.y;
	int col = blockIdx.x * blockDim.x + threadIdx.x;	

	// Abort if out of range
	if (row >= R || col >= C) return;

	c[row * C + col] = a[row * C + col] + b[row * C + col];

	return;
}

/**
* makeMatrix
* 
* initiate a matrix with R,C dimensions
*
*/
void makeMatrix(float* m, int R, int C) {
	for (int i = 0; i < R*C; i++) {
		m[i] = (float)(rand() % 1000)/1000;		
	}
}

/**
* logMatrix
* 
* log a matrix in the console
* 
*/
void logMatrix(float* m, int R, int C) {
	char delim = ',';
	std::cout << "[\n";
	for (int i = 0; i < R; i++) {
		std::cout << "\t";
		for (int j = 0; j < C; j++) {
			delim = (j < C-1) ? ',' : ' ';
			std::cout << m[i * R + j] << delim;
		}
		std::cout << "\n";
	}


	std::cout << "]" << std::endl;
}

int main() {

	int N = 3;
	int M = 2;
	int P = 4;

	float a[M*N];
	makeMatrix(a, M, N);

	float b[P*N];
	makeMatrix(b, N, P);

	float c[P*M];
	makeMatrix(c, M, P);

	float *cudaA = 0;
	float *cudaB = 0;
	float *cudaC = 0;

	std::cout << "Start" << std::endl;
	logMatrix(a, M, N);
	logMatrix(b, N, P);
 	
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
	
	matrixMult<<<BLOCKS, THREADS>>>(cudaA, cudaB, cudaC, N, M, P);
 
	cudaMemcpy(c, cudaC, sizeof(c), cudaMemcpyDeviceToHost);
 	
 	cudaFree(cudaA);
 	cudaFree(cudaB);
 	cudaFree(cudaC);
 
 	logMatrix(c, M, P);

	std::cout << "Finished" << std::endl;

	return 0;
}
