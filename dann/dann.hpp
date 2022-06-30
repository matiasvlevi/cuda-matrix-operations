#include "vector"
#include "../matrix/matrix.cuh"
#include "../layer/layer.hpp"

#ifndef DANN_H
#define DANN_H
class Dann {
private:
    int input_size;
    int output_size;

    float *input;

    std::vector<int> layer_def;

    std::vector<Layer*> layers;
    std::vector<Matrix*> weights;

public: 
    Dann(int nn_input_size, int nn_output_size) {
        input_size = nn_input_size;
        output_size = nn_output_size;

        // Create input layer
        float *input = (float*)malloc(sizeof(float) * input_size);
        Matrix::init_static(input, input_size, 1);
        layers.push_back(new Layer(input, input_size));
    }
    ~Dann() {
        // Free layers
        for (int i = 0; i < layers.size(); i++) {
            free(layers[i]->values); 
        }

        // Free weights
        for (int i = 0; i < weights.size(); i++) {
            free(weights[i]->values);
        }
    }
    void logArch();
    void log();
    void addHiddenLayer(int layer_size);
    void makeWeights();
};
#endif