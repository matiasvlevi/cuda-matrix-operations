#include "vector"
#include "../matrix/matrix.cuh"

#ifdef __CUDACC__
#define CUDA_CALLABLE_MEMBER __host__ __device__
#else
#define CUDA_CALLABLE_MEMBER
#endif 


struct Layer {
    float* values;
    int size;

    Layer(float* layer_values, int layer_size) {
        values = layer_values;
        size = layer_size;
    }
};

struct Matrix {
    float* values;
    int rows;
    int cols;

    Matrix(float* m_values, int m_rows, int m_cols) {
        values = m_values;
        rows = m_rows;
        cols = m_cols;
    }
};


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
        matrix::init(input, input_size, 1);
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