#include "dann.hpp"

void Dann::log() {
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

void Dann::logArch() {
    char delim;
    // Log Architecture
    std::cout << "Architecture: {";

    for (int i = 0; i < layers.size(); i++) {
        delim = (i == 0) ? ' ' : ',';
        std::cout << delim << layers[i]->size; 
    }

    std::cout << " }" << std::endl;
}