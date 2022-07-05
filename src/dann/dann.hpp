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

	std::vector<Layer*> biases;
    std::vector<Layer*> layers;
    std::vector<Matrix*> weights;

    std::vector<mathFunc> activations;
	std::vector<mathFunc> derivatives;
	
	dim3 THREADS;
    dim3 BLOCKS;

	bool unsafe;

	float *tempBuffer;
public:
    Dann(int nn_input_size, int nn_output_size) {
        unsafe = false;
		input_size = nn_input_size;
        output_size = nn_output_size;

        THREADS.x = 16;
        THREADS.y = 16;

        // Create input layer
        float *input = (float*)malloc(sizeof(float) * input_size);
		if (heapOutOfMem(input)) return; 

		Matrix::init_static(input, input_size, 1);
		layers.push_back(new Layer(input, input_size));
	}
    ~Dann() {
        // Free layers
        for (int i = 0; i < layers.size(); i++) {
            free(layers[i]->values); 
			cudaFree(layers[i]->cuda_values);
        }

		for (int i = 0; i < biases.size(); i++) {
			free(biases[i]->values);
			cudaFree(biases[i]->cuda_values);
		}

        // Free weights
        for (int i = 0; i < weights.size(); i++) {
            free(weights[i]->values);
            cudaFree(weights[i]->cuda_values);
        }
		cudaFree(tempBuffer);
	}
    void logArch();
    void log();

    // CUDA methods
    void registerDeviceMem();
    void getDeviceMem();

	bool heapOutOfMem(float* values);

	static float largestSize(std::vector<Layer*> layers);

    // Dannjs Classic methods
	void outputActivation(mathFunc *act);
    void addHiddenLayer(int layer_size, mathFunc *act = &Activation::sigmoid);
    void makeWeights();

    std::vector<float> feedForward(float *input_values);


};
#endif
