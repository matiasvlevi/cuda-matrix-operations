#ifndef LAYER_H
#define LAYER_H
struct Layer {
    float* values;
    float* cuda_values;
    int size;
	std::size_t bsize;

    Layer(float* l_layer_values, int l_layer_size) {
		cuda_values = 0;
		values = l_layer_values;
        size = l_layer_size;
		bsize = sizeof(float) * l_layer_size;
	}
};
#endif
