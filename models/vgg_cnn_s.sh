#!/bin/bash

# VGG_CNN_S
# Epoch: [TESTING SUMMARY] Total Time(s): 175.31  average loss (per batch): 1.56   accuracy [Center](%):   top-1 63.06

export prototxt=/opt/caffe/scripts/models/fd8800eeb36e276cd6f9/VGG_CNN_S_deploy.prototxt
export model=/opt/caffe/scripts/models/fd8800eeb36e276cd6f9/VGG_CNN_S.caffemodel
export batchSize=128
export backend=cudnn
export cropSize=227
export mean_file=./VGG_mean.t7

th main.lua
