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
//		mathFunc h_point;
//		cudaMemcpyFromSymbol(&h_point, , sizeof(mathFunc));

		float *temp = 0;
		cudaMalloc(&temp, layers[i+1]->bsize);
		Kernel::map<<<BLOCKS, THREADS>>>(
			layers[i+1]->cuda_values,
			temp,
			layers[i+1]->size,
			1,
			activations[i]
		);
		cudaMemcpy(layers[i+1]->cuda_values, temp, layers[i+1]->bsize, cudaMemcpyDeviceToDevice);
		cudaFree(temp);
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
