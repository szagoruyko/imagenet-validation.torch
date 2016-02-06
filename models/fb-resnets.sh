#!/bin/bash

export batchSize=16 # to fit in Titan Black
RESNET_PATH=/opt/projects/coco/fastrcnn/data/models/resnet/

# Epoch: [TESTING SUMMARY] Total Time(s): 208.53  average loss (per batch): 1.25   accuracy [Center](%):   top-1 69.31
export model=$RESNET_PATH/resnet-18.t7
th main.lua

# Epoch: [TESTING SUMMARY] Total Time(s): 363.11  average loss (per batch): 1.08   accuracy [Center](%):   top-1 72.94
export model=$RESNET_PATH/resnet-34.t7
th main.lua

# Epoch: [TESTING SUMMARY] Total Time(s): 439.36  average loss (per batch): 0.98   accuracy [Center](%):   top-1 75.76
export model=$RESNET_PATH/resnet-50.t7
th main.lua

# Epoch: [TESTING SUMMARY] Total Time(s): 695.78  average loss (per batch): 0.89   accuracy [Center](%):   top-1 77.34
export model=$RESNET_PATH/resnet-101-exp35.t7
th main.lua
