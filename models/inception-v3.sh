#!/bin/bash

# Epoch: [TESTING SUMMARY] Total Time(s): 156.21  average loss (per batch): 6.47   accuracy [Center](%):   top-1 51.23
export model=/opt/rocks/inception.torch/inception-v3.t7
export classes=/opt/rocks/inception.torch/synsets-1-based.txt
export batchSize=64
export mean_file=/opt/rocks/inception.torch/inception_mean.t7

th main.lua
