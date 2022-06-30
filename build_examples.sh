#!/bin/bash

if [ ! -d "./build" ]; 
then
    mkdir ./build
fi

nvcc ./matrix/*.cu ./examples/transpose_example.cu -o ./build/transpose_example
nvcc ./matrix/*.cu ./examples/add_example.cu -o ./build/add_example