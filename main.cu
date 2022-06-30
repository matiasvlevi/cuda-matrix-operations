#include "dann/dann.hpp"

int main() {


	Dann *nn = new Dann(2, 1);

	nn->addHiddenLayer(4);

	nn->makeWeights();

	nn->log();
	
	return 0;
}
