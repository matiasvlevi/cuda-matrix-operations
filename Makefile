COMPILER=nvcc
FLAGS=--Wreorder --Werror all-warnings --std=c++17 -m64 --relocatable-device-code=true

INC=src/matrix/*.cu src/matrix/kernels/*.cu src/dann/*.cu src/activations/*.cu
HEADERS=src/matrix/*.cuh src/dann/*.hpp src/layer/*.hpp src/activations/activations.hpp
MAIN=src/main.cu

OUTDIR=build
OUTDIR_EXAMPLES=matrix

build: $(INC) $(MAIN) $(HEADERS)
	mkdir -p $(OUTDIR)/$(OUTDIR_EXAMPLES)
	$(COMPILER) $(FLAGS) $(INC) $(MAIN) -o $(OUTDIR)/main 

run:
	build/main

DOT_EXAMPLE=examples/dot_example.cu
ADD_EXAMPLE=examples/add_example.cu
MAP_EXAMPLE=examples/map_example.cu
TRANSPOSE_EXAMPLE=examples/transpose_example.cu

examples: dot_example add_example transpose_example map_example

dot_example: $(INC) $(DOT_EXAMPLE)
	$(COMPILER) $(FLAGS) $(INC) $(DOT_EXAMPLE) -o $(OUTDIR)/$(OUTDIR_EXAMPLES)/dot

add_example: $(INC) $(ADD_EXAMPLE)
	$(COMPILER) $(FLAGS) $(INC) $(ADD_EXAMPLE) -o $(OUTDIR)/$(OUTDIR_EXAMPLES)/add

map_example: $(INC) $(MAP_EXAMPLE)
	$(COMPILER) $(FLAGS) $(INC) $(MAP_EXAMPLE) -o $(OUTDIR)/$(OUTDIR_EXAMPLES)/map

transpose_example: $(INC) $(TRANSPOSE_EXAMPLE)
	$(COMPILER) $(FLAGS) $(INC) $(TRANSPOSE_EXAMPLE) -o $(OUTDIR)/$(OUTDIR_EXAMPLES)/transpose
