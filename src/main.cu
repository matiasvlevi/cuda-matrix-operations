#include "dann/dann.hpp"

int main() {
	using namespace Activation;

	Dann *nn = new Dann(2, 4);

	nn->addHiddenLayer(8, &sigmoid);
	nn->addHiddenLayer(8, &sigmoid);

	nn->outputActivation(&sigmoid);
	nn->makeWeights();
	nn->log();

	nn->registerDeviceMem();

	float input[2] = {1, 1};
	std::vector<float> out = nn->feedForward(input);

	Matrix::logVector(out);
	
	return 0;
}
