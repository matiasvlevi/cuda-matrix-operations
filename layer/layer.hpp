#ifndef LAYER_H
#define LAYER_H
struct Layer {
    float* values;
    int size;

    Layer(float* layer_values, int layer_size) {
        values = layer_values;
        size = layer_size;
    }
};
#endif