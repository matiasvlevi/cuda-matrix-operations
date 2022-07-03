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
	__host__ __device__ float linear(float x);
	__host__ __device__ float sigmoid(float x);

	namespace Derivative {
		__host__ __device__ float linear_d(float x); 
		__host__ __device__ float sigmoid_d(float x);
	}
}
#endif
 
