#include "matrix.cuh"

/**
* init
* 
* initiate a  with R,C dimensions
*
*/
void matrix::init(float* m, int R, int C) {
    for (int i = 0; i < R*C; i++) {
        m[i] = 0;		
    }
}

/**
* initRandom
* 
* initiate a  with R,C dimensions
*
*/
void matrix::initRandom(float* m, int R, int C) {
    for (int i = 0; i < R*C; i++) {
        m[i] = (float)(rand() % (1 << 10))/(1 << 10);		
    }
}