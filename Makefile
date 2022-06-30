
COMPILER=nvcc

INC=matrix/*.cu matrix/kernels/*.cu dann/*.cu

MAIN=main.cu

OUTDIR=build
OUTDIR_EXAMPLES=matrix

DOT_EXAMPLE=examples/dot_example.cu
ADD_EXAMPLE=examples/add_example.cu
TRANSPOSE_EXAMPLE=examples/transpose_example.cu

[ -d $(OUTDIR)/$(OUTDIR_EXAMPLES) ] || mkdir -p $(OUTDIR)/$(OUTDIR_EXAMPLES)

build: $(INC) $(MAIN)
	$(COMPILER) $(INC) $(MAIN) -o $(OUTDIR)/main 

example: dot_example add_example transpose_example

dot_example: $(INC) $(DOT_EXAMPLE)
	$(COMPILER) $(INC) $(DOT_EXAMPLE) -o $(OUTDIR)/$(OUTDIR_EXAMPLES)/dot

add_example: $(INC) $(ADD_EXAMPLE)
	$(COMPILER) $(INC) $(ADD_EXAMPLE) -o $(OUTDIR)/$(OUTDIR_EXAMPLES)/add

transpose_example: $(INC) $(TRANSPOSE_EXAMPLE)
	$(COMPILER) $(INC) $(TRANSPOSE_EXAMPLE) -o $(OUTDIR)/$(OUTDIR_EXAMPLES)/transpose