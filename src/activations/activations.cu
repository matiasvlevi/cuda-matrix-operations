#include "activations.hpp"

namespace Activation {
	float linear(float x) {
		return x;
	}

	float sigmoid(float x) {
		return 1 / (1 + exp(-x));
	}
	
	namespace Derivative {
		float linear_d(float x) {
			return 1;
		}
	
		float sigmoid_d(float x) {
			float x1 = 1 / (1 + exp(-x));
			return x1 * (1 - x1);
		}
	}
}

