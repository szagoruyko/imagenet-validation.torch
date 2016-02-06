#!/bin/bash

export batchSize=32
export backend=cudnn
export mean_file=/tmp/vgg16_mean.t7
THCMD=`th -e "torch.save('$mean_file', torch.Tensor{103.939, 116.779, 123.68}:view(1,1,3):expand(256,256,3))"`


# Epoch: [TESTING SUMMARY] Total Time(s): 738.82  average loss (per batch): 1.19   accuracy [Center](%):  top-1 70.62
export prototxt=/opt/caffe/scripts/models/211839e770f7b538e2d8/VGG_ILSVRC_16_layers_deploy.prototxt
export model=/opt/caffe/scripts/models/211839e770f7b538e2d8/VGG_ILSVRC_16_layers.caffemodel

th main.lua


# Epoch: [TESTING SUMMARY] Total Time(s): 898.13  average loss (per batch): 1.19   accuracy [Center](%):  top-1 70.74
export prototxt=/opt/caffe/scripts/models/3785162f95cd2d5fee77/VGG_ILSVRC_19_layers_deploy.prototxt
export model=/opt/caffe/scripts/models/3785162f95cd2d5fee77/VGG_ILSVRC_19_layers.caffemodel

th main.lua
