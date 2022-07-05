#include "dann.hpp"

float Dann::largestSize(std::vector<Layer*> layers) {
	float largest = 0;
	for (int i = 0; i < layers.size(); i++) {
		if (layers[i]->bsize > largest) {
			largest = layers[i]->bsize;
		}
	}
	return largest;
}
