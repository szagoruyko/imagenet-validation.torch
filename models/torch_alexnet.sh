#!/bin/bash

# Epoch: [TESTING SUMMARY] Total Time(s): 170.56  average loss (per batch): 1.86   accuracy [Center](%):   top-1 56.50

export model=/home/zagoruys/raid/Zoo/torch/alexnet/model_55.t7
export batchSize=128
export backend=cudnn
export cropSize=227
export classes=/home/zagoruys/raid/Zoo/torch/alexnet/classes.t7

th main.lua
