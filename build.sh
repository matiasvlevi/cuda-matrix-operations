#!/bin/bash

if [ ! -d "./build" ]; 
then
    mkdir ./build
fi

build_examples () {
    nvcc ./matrix/*.cu ./examples/transpose_example.cu -o ./build/transpose_example
    echo "built transpose_example"
    nvcc ./matrix/*.cu ./examples/add_example.cu -o ./build/add_example
    echo "built add_example"
}

build_main () {
    nvcc ./matrix/*.cu ./main.cu -o ./build/main
    echo "built main"
}

if [[ $1 -eq "--examples" ]] || [[ $1 -eq "-e" ]];
then 
    build_examples;
fi

build_main
