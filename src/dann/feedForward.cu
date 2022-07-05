#include "dann.hpp"

std::vector<float> Dann::feedForward(float *input) {
	if (unsafe) {
		std::vector<float> output;
		return output;
	};

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

		Kernel::add<<<BLOCKS, THREADS>>>(
			biases[i]->cuda_values,
			layers[i+1]->cuda_values,
			tempBuffer,
			biases[i]->size,
			1
		);

		cudaMemcpy(layers[i+1]->cuda_values, tempBuffer, layers[i+1]->bsize, cudaMemcpyDeviceToDevice);

		Kernel::map<<<BLOCKS, THREADS>>>(
			layers[i+1]->cuda_values,
			tempBuffer,
			layers[i+1]->size,
			1,
			activations[i]
		);

		cudaMemcpy(layers[i+1]->cuda_values, tempBuffer, layers[i+1]->bsize, cudaMemcpyDeviceToDevice);
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
