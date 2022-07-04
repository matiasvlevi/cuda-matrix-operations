#include "dann.hpp"

void Dann::addHiddenLayer(int layer_size, mathFunc *act) {
    // Create hidden layer
    float *layer = (float*)malloc(sizeof(float) * layer_size);
    Matrix::init_static(layer, layer_size, 1);

    layers.push_back(new Layer(layer, layer_size));
	

	mathFunc h_activation;
	cudaMemcpyFromSymbol(&h_activation, *act, sizeof(mathFunc));
	activations.push_back(h_activation);

	//activations.push_back(new ActFunc(act, act));

}
