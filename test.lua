--
--  Copyright (c) 2014, Facebook, Inc.
--  All rights reserved.
--
--  This source code is licensed under the BSD-style license found in the
--  LICENSE file in the root directory of this source tree. An additional grant
--  of patent rights can be found in the PATENTS file in the same directory.
--
local testDataIterator = function()
   testLoader:reset()
   return function() return testLoader:get_batch(false) end
end

local batchNumber
local top1_center, loss
local timer = torch.Timer()

function test()
   print('==> doing epoch on validation data:')

   batchNumber = 0
   cutorch.synchronize()
   timer:reset()

   -- set the dropouts to evaluate mode
   model:evaluate()

   top1_center = 0
   loss = 0
   -- nTest = 4096
   for i=1,nTest/opt.batchSize do -- nTest is set in 1_data.lua
      local indexStart = (i-1) * opt.batchSize + 1
      local indexEnd = (indexStart + opt.batchSize - 1)
      donkeys:addjob(
         -- work to be done by donkey thread
         function()
            local inputs, labels = testLoader:get(indexStart, indexEnd)
            return inputs, labels
         end,
         -- callback that is run in the main thread once the work is done
         testBatch
      )
   end

   donkeys:synchronize()
   cutorch.synchronize()

   top1_center = top1_center * 100 / nTest
   loss = loss / (nTest/opt.batchSize) -- because loss is calculated per batch
   print(string.format('Epoch: [TESTING SUMMARY] Total Time(s): %.2f \t'
                          .. 'average loss (per batch): %.2f \t '
                          .. 'accuracy [Center](%%):\t top-1 %.2f\t ',
                       timer:time().real, loss, top1_center))

   print('\n')


end -- of test()
-----------------------------------------------------------------------------
local inputs = torch.CudaTensor()
local labels = torch.CudaTensor()

local criterion = nn.CrossEntropyCriterion():cuda()

function testBatch(inputsCPU, labelsCPU)
   batchNumber = batchNumber + opt.batchSize

   inputs:resize(inputsCPU:size()):copy(inputsCPU)
   labels:resize(labelsCPU:size()):copy(labelsCPU)

   local outputs = model:forward(inputs)
   local err = criterion:forward(outputs, labels)
   cutorch.synchronize()
   local pred = outputs:float()

   loss = loss + err

   local _, pred_sorted = pred:sort(2, true)
   for i=1,pred:size(1) do
      local g = labelsCPU[i]
      if pred_sorted[i][1] == g then top1_center = top1_center + 1 end
   end
   if batchNumber % 1024 == 0 then
      print(('Epoch: Testing [%d/%d]'):format(batchNumber, nTest))
   end
end
