#include <math.h>

#ifndef MATHFUNC_H
#define MATHFUNC_H
typedef float(*mathFunc)(float);
#endif

#ifdef ACTFUNC_H
#define ACTFUNC_H
struct ActFunc {
	mathFunc activation;
	mathFunc derivative;
}
#endif

#ifndef ACTIVATION_H
#define ACTIVATION_H
namespace Activation {
	float linear(float x);
	float sigmoid(float x);
	
	namespace Derivative {
		float linear_d(float x); 
		float sigmoid_d(float x);
	}
}
#endif

