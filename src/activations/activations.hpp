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

#ifndef ACTPOINTER_H
#define ACTPOINTER_H
namespace ActPointer {
	__host__ __device__ float linear(float x);
	__host__ __device__ float sigmoid(float x);	

	namespace Derivative {
		__host__ __device__ float linear(float x); 
		__host__ __device__ float sigmoid(float x);
	}
}
#endif

#ifndef ACTIVATION_H
#define ACTIVATION_H
namespace Activation {
	extern __device__ mathFunc sigmoid;
	extern __device__ mathFunc linear;

	namespace Derivative {
		extern __device__ mathFunc sigmoid;
		extern __device__ mathFunc linear;
	}
}
#endif

