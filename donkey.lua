--
--  Copyright (c) 2014, Facebook, Inc.
--  All rights reserved.
--
--  This source code is licensed under the BSD-style license found in the
--  LICENSE file in the root directory of this source tree. An additional grant
--  of patent rights can be found in the PATENTS file in the same directory.
--
require 'image'
paths.dofile('dataset.lua')
local tablex = require 'pl.tablex'

-- This file contains the data-loading logic and details.
-- It is run by each data-loader thread.
------------------------------------------

-- a cache file of the training metadata (if doesnt exist, will be created)
local testCache = paths.concat(opt.cache, 'testCache.t7')

-- Check for existence of opt.data
if not os.execute('cd ' .. opt.data) then
    error(("could not chdir to '%s'"):format(opt.data))
end

local loadSize   = {3, opt.imageSize, opt.imageSize}
local sampleSize = {3, opt.cropSize, opt.cropSize}


local function loadImage(path)
   local input = image.load(path, 3, 'float')
   -- find the smaller dimension, and resize it to loadSize (while keeping aspect ratio)
   if input:size(3) < input:size(2) then
      input = image.scale(input, loadSize[2], loadSize[3] * input:size(2) / input:size(3))
   else
      input = image.scale(input, loadSize[2] * input:size(3) / input:size(2), loadSize[3])
   end
   return input
end

local mean = opt.transformer.mean
local std = opt.transformer.std

if torch.isTensor(mean) then
   mean = mean:permute(3,1,2):float()
   mean = image.scale(mean, opt.cropSize, opt.cropSize)
end

-- function to load the image
testHook = function(self, path)
   collectgarbage()
   local input = loadImage(path)
   local oH = sampleSize[2]
   local oW = sampleSize[3]
   local iW = input:size(3)
   local iH = input:size(2)
   local w1 = math.ceil((iW-oW)/2)
   local h1 = math.ceil((iH-oH)/2)
   local out = image.crop(input, w1, h1, w1+oW, h1+oH) -- center patch
   -- mean/std
   if torch.isTensor(mean) then
      out = out:index(1,opt.transformer.swap)
      out:mul(opt.transformer.scale):add(-1,mean)
   else
      for i=1,3 do -- channels
         if mean then out[i]:add(-mean[i]) end
         if std then out[i]:div(std[i]) end
      end
   end
   return out
end

local tmp_path = '/tmp/testLoader.t7'

local function createLoader()
   print('Creating test metadata')
   testLoader = dataLoader{
      paths = {paths.concat(opt.data, 'val')},
      loadSize = loadSize,
      sampleSize = sampleSize,
      split = 0,
      verbose = true,
      forceClasses = opt.classes -- force consistent class indices between trainLoader and testLoader
   }
   torch.save(tmp_path, testLoader)
end

assert(opt.classes)

if not paths.filep(tmp_path) then
   createLoader()
else
   testLoader = torch.load(tmp_path)
   if not tablex.deepcompare(testLoader.classes, opt.classes) 
      or not tablex.deepcompare(testLoader.sampleSize, sampleSize)
      or not tablex.deepcompare(testLoader.loadSize, loadSize) then
      createLoader()
   end
end

testLoader.sampleHookTest = testHook
