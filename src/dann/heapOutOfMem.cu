#include "dann.hpp"

bool Dann::heapOutOfMem(float* values) {
	if (values == NULL) {
		unsafe = true;
		std::cout << "Heap out of memory" << std::endl;
		return true;
	} else {
		return false;
	}
}
