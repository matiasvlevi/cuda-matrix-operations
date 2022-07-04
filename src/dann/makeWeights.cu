#include "dann.hpp"

void Dann::makeWeights() {

    // Create output layer
    float *output = (float*)malloc(sizeof(float) * output_size);
	if (heapOutOfMem(output)) return;

	Matrix::init_static(output, output_size, 1);
    layers.push_back(new Layer(output, output_size));

	// Create a bias layer
    float *bias_layer = (float*)malloc(sizeof(float) * output_size);
	if (heapOutOfMem(bias_layer)) return;

	Matrix::init_static(bias_layer, output_size, 1);
    biases.push_back(new Layer(bias_layer, output_size));

	// Initiate Device's pointer to the activation function
	mathFunc h_pointFunc;
	cudaMemcpyFromSymbol(&h_pointFunc, Activation::sigmoid, sizeof(mathFunc));	
	activations.push_back(h_pointFunc);

    // Weights
    for (int i = 1; i < layers.size(); i++) {
        float *hidden_w = (float*)malloc(sizeof(float) * layers[i]->size * layers[i-1]->size);
		if (heapOutOfMem(hidden_w)) return;
		
		Matrix::initRandomf_static(hidden_w, layers[i]->size, layers[i-1]->size);
        
		weights.push_back(
            new Matrix(hidden_w, layers[i]->size, layers[i-1]->size)
        );
    }

}
