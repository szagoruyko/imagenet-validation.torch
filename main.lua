require 'torch'
require 'cudnn'
require 'cunn'
require 'paths'
require 'xlua'
require 'nn'
require 'loadcaffe'
local matio = require 'matio'

torch.setdefaulttensortype('torch.FloatTensor')

opt = {
   imageSize = 256,
   cropSize = 224,
   data = './imagenet_raw_images/256',
   backend = 'nn',
   nDonkeys = 4,
   cache = './imagenet',
   model = '/opt/projects/coco/fastrcnn/data/models/resnet/resnet-34.t7',
   prototxt = '',
   batchSize = 128,
   mean_file = 'torch',
   classes = './data/synset_words.txt',
}
for k,v in pairs(opt) do opt[k] = tonumber(os.getenv(k)) or os.getenv(k) or opt[k] end
print(opt)

if opt.model:find'caffemodel' then
   model = loadcaffe.load(opt.prototxt, opt.model, opt.backend)
   model.modules[#model.modules] = nil
else
   model = torch.load(opt.model)
end
print(model)

if opt.mean_file == 'torch' then
   opt.transformer = {
      mean = {
         0.48462227599918,
         0.45624044862054,
         0.40588363755159,
      },
      std = {
         0.22889466674951,
         0.22446679341259,
         0.22495548344775,
      }
   }
else
   opt.transformer = {
      mean = torch.load(opt.mean_file),
      scale = 255,
      swap = torch.LongTensor{3,2,1},
   }
end

if opt.classes:sub(-2) == 't7' then
   opt.classes = torch.load(opt.classes)
else
   local classes = {}
   for line in io.lines(opt.classes) do table.insert(classes, line:sub(1,9)) end
   opt.classes = classes
end

paths.dofile('data.lua')
paths.dofile('test.lua')

test()
