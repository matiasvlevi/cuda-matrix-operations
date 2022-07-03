#include "activations.hpp"

namespace Activation {
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
		float linear_d(float x) {
			return 1;
		}
	
		__host__ __device__
		float sigmoid_d(float x) {
			float x1 = 1 / (1 + exp(-x));
			return x1 * (1 - x1);
		}
	}
}

