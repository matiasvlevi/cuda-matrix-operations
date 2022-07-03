#include "matrix.cuh"



/**
* log
* 
* log a  in the console
* 
*/
void Matrix::log_static(float* m, int R, int C, char name) {
    char delim = ',';
    std::cout << name << " [\n";
    for (int i = 0; i < R; i++) {
        std::cout << "\t";
        for (int j = 0; j < C; j++) {
            delim = (j < C-1) ? ',' : ' ';
            std::cout << m[i * C + j] << delim;
        }
        std::cout << "\n";
    }

    std::cout << "]\n" << std::endl;
}

/**
* log
* 
* log a  in the console
* 
*/
void Matrix::log(char name) {
    char delim = ',';
    std::cout << name << " [\n";
    for (int i = 0; i < rows; i++) {
        std::cout << "\t";
        for (int j = 0; j < cols; j++) {
            delim = (j == 0) ? ' ' : ',';
            std::cout << delim << values[i * cols + j];
        }
        std::cout << "\n";
    }

    std::cout << "]\n" << std::endl;
}

void Matrix::logVector(std::vector<float> input) {
    std::cout << "Vector [\n";
    
    for (int i = 0; i < input.size(); i++) 
        std::cout << "\t" << input[i] << ",\n";
    
    std::cout << "]" << std::endl;
}