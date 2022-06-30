#include <iostream>

__global__ 
void addLists(int *a, int *b, int *c) {
	int i = threadIdx.x;
	c[i] = a[i] + b[i];
	return;
}

int main() {

	int N = 12;

	int a[N] = { 2, 3, 1, 1, 4, 1, 3, 5, 2, 4, 4, 5 };
	int b[N] = { 1, 2, 5, 6, 2, 1, 4, 5, 6, 7, 8, 2 };
	int c[N] = { 0 };

	int *cudaA = 0;
	int *cudaB = 0;
	int *cudaC = 0;

	cudaMalloc(&cudaA, sizeof(a));
	cudaMalloc(&cudaB, sizeof(b));
	cudaMalloc(&cudaC, sizeof(c));

	cudaMemcpy(cudaA, a, sizeof(a), cudaMemcpyHostToDevice);
	cudaMemcpy(cudaB, b, sizeof(b), cudaMemcpyHostToDevice);
	cudaMemcpy(cudaC, c, sizeof(c), cudaMemcpyHostToDevice);

	addLists<<<1, N>>>(cudaA, cudaB, cudaC);
	
	cudaMemcpy(c, cudaC, sizeof(c), cudaMemcpyDeviceToHost);
	
	for (int i = 0; i < N; i++) 
		std::cout << c[i] << std::endl;

	return 0;
}
