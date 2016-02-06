imagenet-validation.torch
=========================

A modified subset of https://github.com/soumith/imagenet-multiGPU.torch to allow
easy testing of imagenet models.

Also used to make sure that models converted from other frameworks are correct.

# Evaluation

|Model name| top-1 (central crop) accuracy | test time (s) | framework | trained by |
|---|:---:|:---:|:---:|:---:|
|NIN          | 0(?) | __155.66__ | caffe | authors |
|inception-v2 | 51.00(?) | 156.21 | ? | google |
|inception-v3 | __78.53__ | 536.67 | ? | google |
|bvlc_alexnet | 54.61 | 172.29 | caffe | bvlc |
|bn-alexnet   | 56.60 | 170.56 | torch | me  |
|VGG_CNN_S    | 63.06 | 175.31 | caffe | VGG |
|VGG-16       | 70.62 | 738.82 | caffe | VGG |
|VGG-19       | 70.74 | 898.13 | caffe | VGG |
|ResNet-18    | 69.31 | 208.53 | torch | facebook |
|ResNet-34    | 72.94 | 363.11 | torch | facebook |
|ResNet-50    | 75.76 | 439.36 | torch | facebook |
|ResNet-101   | 77.34 | 695.78 | torch | facebook |

Time is given for Titan Black.
