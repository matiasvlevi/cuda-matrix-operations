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
	
	Dann *nn = new Dann(2, 2);

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

Here is the equivalent using Dannjs

```js
const nn = new Dann(2, 2);

nn.addHiddenLayer(8, 'sigmoid');
nn.addHiddenLayer(8, 'sigmoid');

nn.outputActivation('sigmoid');
nn.makeWeights();
nn.log();

let out = nn.feedForward([1, 1]);

console.log(out);
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
