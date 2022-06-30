#!/bin/bash

if [ ! -d "./build" ]; 
then
    mkdir ./build
fi

nvcc ./matrix/*.cu ./main.cu -o ./build/main