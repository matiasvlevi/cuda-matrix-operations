#include "dann.hpp"

void Dann::addHiddenLayer(int layer_size, mathFunc *act) {
    // Create hidden layer
    float *layer = (float*)malloc(sizeof(float) * layer_size);
	if (heapOutOfMem(layer)) return;

	Matrix::init_static(layer, layer_size, 1);
    layers.push_back(new Layer(layer, layer_size));


	// Create a bias layer
	float *bias_layer = (float*)malloc(sizeof(float) * layer_size);
	if (heapOutOfMem(bias_layer)) return;

    Matrix::initRandomf_static(bias_layer, layer_size, 1);
	biases.push_back(new Layer(bias_layer, layer_size));


	// Initialize the Device's pointer to the activation function 
	mathFunc h_activation;
	cudaMemcpyFromSymbol(&h_activation, *act, sizeof(mathFunc));
	activations.push_back(h_activation);
}
