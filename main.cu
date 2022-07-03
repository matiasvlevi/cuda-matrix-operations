#include "dann/dann.hpp"

int main() {
	Dann *nn = new Dann(2, 4);

	nn->addHiddenLayer(8);
	nn->makeWeights();
	nn->log();
	
	nn->registerDeviceMem();

    float input[2] = {1, 1};
	std::vector<float> out = nn->feedForward(input);

	Matrix::logVector(out);

	return 0;
}
