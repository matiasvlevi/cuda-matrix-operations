#include "dann.hpp"

std::vector<float> Dann::feedForward(float *input) {
	
	layers[0]->values = input;

    cudaMemcpy(
        layers[0]->cuda_values,
        layers[0]->values,
        layers[0]->bsize,
        cudaMemcpyHostToDevice
    );

	int blocks;

    for (int i = 0; i < weights.size(); i++) {

        blocks = (weights[i]->cols + THREADS.x-1) / THREADS.x;

        BLOCKS.x = blocks;
        BLOCKS.y = blocks;

		Kernel::dot<<<BLOCKS, THREADS>>>(
            weights[i]->cuda_values,
            layers[i]->cuda_values,
            layers[i+1]->cuda_values,
            weights[i]->cols,
			weights[i]->rows,
			1
		);
	}

    cudaMemcpy(
        layers[layers.size()-1]->values,
        layers[layers.size()-1]->cuda_values,
        layers[layers.size()-1]->bsize,
        cudaMemcpyDeviceToHost
    );

    std::vector<float> output{
        layers[layers.size()-1]->values,
        layers[layers.size()-1]->values + layers[layers.size()-1]->size
    };

    return output;
}
