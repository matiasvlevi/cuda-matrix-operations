# CUDA Matrix operations

Work in progress

### Build

```
make
```

### Usage

Here is a simple neural network performing a feed forward in the GPU

```cpp
#include "dann/dann.hpp"

int main() {
	
	Dann *nn = new Dann(2, 4);

	nn->addHiddenLayer(8, &Activation::sigmoid);
	nn->addHiddenLayer(8, &Activation::sigmoid);

	nn->outputActivation(&Activation::sigmoid);
	nn->makeWeights();
	nn->log();

	nn->registerDeviceMem();

	float input[2] = {1, 1};
	std::vector<float> out = nn->feedForward(input);

	Matrix::logVector(out);
	
	return 0;
}
```


#### Build examples (optional)
Matrix operation examples are provided
```
make examples
```

### Run

```
make run
```
