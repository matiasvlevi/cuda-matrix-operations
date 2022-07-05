#include "activations.hpp"

namespace ActPointer {
	__host__ __device__
	float linear(float x) {
		return x;
	}

	__host__ __device__
	float sigmoid(float x) {
		return 1 / (1 + exp(-x));
	}

	namespace Derivative {
		__host__ __device__
		float linear(float x) {
			return 1;
		}
	
		__host__ __device__
		float sigmoid(float x) {
			float x1 = 1 / (1 + exp(-x));
			return x1 * (1 - x1);
		}
	}
};

__device__ mathFunc Activation::sigmoid = ActPointer::sigmoid;
__device__ mathFunc Activation::linear = ActPointer::linear;
__device__ mathFunc Activation::Derivative::sigmoid = ActPointer::Derivative::sigmoid;
__device__ mathFunc Activation::Derivative::linear = ActPointer::Derivative::linear;
