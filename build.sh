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
    nvcc ./matrix/*.cu ./examples/dot_example.cu -o ./build/dot_example
    echo "built dot_example"
}

build_main () {
    nvcc ./matrix/*.cu ./main.cu -o ./build/main
    echo "built main"
}

if [[ $1 == "--examples" ]] || [[ $1 == "-e" ]];
then 
    build_examples;
fi

build_main
