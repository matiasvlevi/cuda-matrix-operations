#include "matrix.cuh"

/**
* init
* 
* initiate a  with R,C dimensions
*
*/
void matrix::init(float* m, int R, int C) {
    for (int i = 0; i < R*C; i++) {
        m[i] = (float)(rand() % 10);		
    }
}