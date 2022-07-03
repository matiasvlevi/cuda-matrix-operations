#include "matrix.cuh"

/**
* init
* 
* initiate a  with R,C dimensions
*
*/
void Matrix::init_static(float* m, int R, int C) {
    for (int i = 0; i < R*C; i++) {
        m[i] = 0;		
    }
}

/**
* init
* 
* initiate a  with R,C dimensions
*
*/
void Matrix::init() {
    for (int i = 0; i < rows*cols; i++) {
        values[i] = 0;		
    }
}


/**
* initRandomi
* 
* initiate a  with R,C dimensions
*
*/
void Matrix::initRandomi_static(float* m, int R, int C) {
    for (int i = 0; i < R*C; i++) {
        m[i] = rand() % 10;		
    }
}

/**
* initRandomi
* 
* initiate a  with R,C dimensions
*
*/
void Matrix::initRandomi() {
    for (int i = 0; i < rows*cols; i++) {
        values[i] = rand() % 10;		
    }
}

/**
* initRandomf
* 
* initiate a  with R,C dimensions
*
*/
void Matrix::initRandomf_static(float* m, int R, int C) {
    for (int i = 0; i < R*C; i++) {
        m[i] = (float)(rand() % (1 << 10))/(1 << 10);		
    }
}

/**
* initRandomf
* 
* initiate a  with R,C dimensions
*
*/
void Matrix::initRandomf() {
    for (int i = 0; i < rows*cols; i++) {
        values[i] = (float)(rand() % (1 << 10))/(1 << 10);		
    }
}