#include "dann.hpp"

void Dann::makeWeights() {

    // Create output layer
    float *output = (float*)malloc(sizeof(float) * input_size);
    Matrix::init_static(output, output_size, 1);
    layers.push_back(new Layer(output, output_size));

    // Weights
    for (int i = 1; i < layers.size(); i++) {
        float *hidden_w = (float*)malloc(sizeof(float) * layers[i]->size * layers[i-1]->size);
        Matrix::initRandomf_static(hidden_w, layers[i]->size, layers[i-1]->size);
        
		weights.push_back(
            new Matrix(hidden_w, layers[i]->size, layers[i-1]->size)
        );
    }

}
