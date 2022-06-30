#include "matrix.cuh"

/**
* log
* 
* log a  in the console
* 
*/
void matrix::log(float* m, int R, int C, char name) {
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