#include "dann.hpp"

void Dann::registerDeviceMem() {
	if (unsafe) return;

	// Register layer values
	for (int i = 0; i < layers.size(); i++) {
		cudaMalloc(&(layers[i]->cuda_values), layers[i]->bsize);    
	}

    // Register weight values
	for (int i = 0; i < weights.size(); i++) {
		cudaMalloc(&(weights[i]->cuda_values), weights[i]->bsize);

        cudaMemcpy(
            weights[i]->cuda_values,
            weights[i]->values,
            weights[i]->bsize,
            cudaMemcpyHostToDevice
        );	
	}
}
