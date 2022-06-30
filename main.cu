#include "dann/dann.hpp"

int main() {
	
	Dann *nn = new Dann(2, 2);
	nn->addHiddenLayer(8);
	nn->addHiddenLayer(8);
	nn->makeWeights();
	nn->log();

	return 0;
}
