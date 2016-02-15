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

# Networks

1. __inception-v2__: https://github.com/soumith/inception.torch
2. __inception-v3__: https://github.com/szagoruyko/inception-v3.torch
3. __bvlc_alexnet__: https://github.com/BVLC/caffe/tree/master/models/bvlc_alexnet
4. __bn_alexnet__: https://gist.github.com/szagoruyko/dd032c529048492630fc
5. __VGG_CNN_S__: https://gist.github.com/ksimonyan/fd8800eeb36e276cd6f9#file-readme-md
6. __VGG-16__: https://gist.github.com/ksimonyan/211839e770f7b538e2d8#file-readme-md
7. __VGG-19__: https://gist.github.com/ksimonyan/3785162f95cd2d5fee77#file-readme-md
