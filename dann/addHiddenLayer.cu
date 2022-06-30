#include "dann.hpp"

void Dann::addHiddenLayer(int layer_size) {
    // Create hidden layer
    float *layer = (float*)malloc(sizeof(float) * layer_size);
    matrix::init(layer, layer_size, 1);

    layers.push_back(new Layer(layer, layer_size));
}