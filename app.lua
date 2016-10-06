local app = require('waffle')
local s3 = require('s3')
local ML = require('ml')

local bucket = s3:connect{
  awsId="<Your AWS ID here>",
  awsKey="<Your AWS Secret Key here>",
  bucket="<target bucket name here>",
}

app.get('/', function(req, res)
   res.send('Hello from our LuaJIT/Torch microservice!')
   end)

app.post('/train', function(req, res)
  if req.body then
    if req.body.files and type(req.body.files) == 'table' then
      for i, s3file in ipairs(req.body.files) do
        -- Training file: s3file
        ML.handleTrainFile(s3file, bucket:get(s3file))
      end
      res.status(200).send("OK")
    end
  end
  res.status(500).send("Bad POST /train request, need 'files : [ <s3 path>, ...]' in the body")
  end)

app.post('/input', function(req, res)
  if req.body then
    if req.body.files and type(req.body.files) == 'table' then
      for i, s3file in ipairs(req.body.files) do
        -- Input file: s3file
        ML.handleInputFile(s3file, bucket:get(s3file))
      end
      res.status(200).send("OK")
    end
  end
  res.status(500).send("Bad POST /input request, need 'files : [ <s3 path>, ...]' in the body")
  end)

app.get('/output', function(req, res)
  output = {}
  if req.body then
    if req.body.files and type(req.body.files) == 'table' then
      for i, s3file in ipairs(req.body.files) do
        -- Output file: s3file
        output = ML.handleOutputFile(s3file, bucket:get(s3file))
      end
      res.json(output)
    end
  end
  res.status(500).send("Bad POST /output request, need 'files : [ <s3 path>, ...]' in the body")
  end)

app.listen({host = '0.0.0.0', port=8080})

