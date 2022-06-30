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
    void logArch() {
        char delim;
        // Log Architecture
        std::cout << "Architecture: {";

        for (int i = 0; i < layers.size(); i++) {
            delim = (i == 0) ? ' ' : ',';
            std::cout << delim << layers[i]->size; 
        }

        std::cout << " }" << std::endl;
    }
    void log() {
        this->logArch();

        // Log layers
        for (int i = 0; i < layers.size(); i++) {
            matrix::log(layers[i]->values, layers[i]->size, 1);
        }

        // Log weights
        for (int i = 0; i < weights.size(); i++) {
            matrix::log(weights[i]->values, weights[i]->rows, weights[i]->cols);
        }
    }
    void addHiddenLayer(int layer_size) {
        // Create hidden layer
        float *layer = (float*)malloc(sizeof(float) * layer_size);
        matrix::init(layer, layer_size, 1);

        layers.push_back(new Layer(layer, layer_size));
    }
    void makeWeights() {

        // Create output layer
        float *output = (float*)malloc(sizeof(float) * input_size);
        matrix::init(output, output_size, 1);
        layers.push_back(new Layer(output, output_size));

        // Weights
        for (int i = 1; i < layers.size(); i++) {
            float *hidden_w = (float*)malloc(sizeof(float) * layers[i]->size * layers[i-1]->size);
            matrix::initRandom(hidden_w, layers[i]->size, layers[i-1]->size);
            weights.push_back(new Matrix(hidden_w, layers[i]->size, layers[i-1]->size));
        }

    }
};
#endif