#!/bin/bash

export model=/opt/rocks/imagenet-tutorials/nin_imagenet.caffemodel
export prototxt=/opt/rocks/imagenet-tutorials/deploy.prototxt
export backend=cudnn
export mean_file=./data/ilsvrc_2012_mean.t7

th main.lua
