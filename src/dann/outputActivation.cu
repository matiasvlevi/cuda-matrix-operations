#include "dann.hpp"

void Dann::outputActivation(mathFunc *act) {
	mathFunc h_pointFunc;
	cudaMemcpyFromSymbol(&h_pointFunc, *act, sizeof(mathFunc));	
	activations[activations.size()-1] = h_pointFunc;
}
