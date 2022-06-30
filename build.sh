#!/bin/bash

build_matrix_examples () {
    if [ ! -d "./build/matrix" ]; 
    then
        mkdir -p ./build/matrix
    fi
    nvcc ./matrix/*.cu ./matrix/kernels/*.cu ./examples/transpose_example.cu -o ./build/matrix/transpose
    echo "built transpose example"
    nvcc ./matrix/*.cu ./matrix/kernels/*.cu ./examples/add_example.cu -o ./build/matrix/add
    echo "built add example"
    nvcc ./matrix/*.cu ./matrix/kernels/*.cu ./examples/dot_example.cu -o ./build/matrix/dot
    echo "built dot example"
}

build_main () {
    if [ ! -d "./build" ]; 
    then
        mkdir ./build
    fi
    nvcc ./matrix/*.cu ./matrix/kernels/*.cu ./dann/*.cu ./main.cu -o ./build/main
    echo "built main"
}

if [[ $1 == "--examples" ]] || [[ $1 == "-e" ]];
then 
    build_matrix_examples;
else
    build_main
fi


