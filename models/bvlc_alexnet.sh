#!/bin/bash

# BVLC alexnet
# Epoch: [TESTING SUMMARY] Total Time(s): 172.29  average loss (per batch): 1.97   accuracy [Center](%):   top-1 54.61

export prototxt=/opt/caffe/models/bvlc_alexnet/deploy.prototxt
export model=/opt/caffe/models/bvlc_alexnet/bvlc_alexnet.caffemodel
export batchSize=256
export backend=cudnn
export cropSize=227
export mean_file=./data/ilsvrc_2012_mean.t7

th main.lua
