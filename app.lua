local app = require('waffle')
local s3 = require('s3')

local bucket = s3:connect{
  awsId="<Your AWS ID here>",
  awsKey="<Your AWS Secret Key here>",
  bucket="<target bucket name here>",
}

function handleOutputFile(file)
  -- TODO: Placeholder for real ML processing
  -- Dear ML Engineer who's gonna read this,
  -- Feel free to use your model to return the
  -- output vector of your model.
  return 42
end

function handleTrainFile(file)
  -- TODO: Placeholder for real ML processing per row
  -- Dear ML Engineer who's gonna read this,
  -- Feel free to train your model inside this function.
  -- Each file will be received, printing them will show
  -- their format.
  print(file);
end

function handleInputFile(file)
  -- TODO: Placeholder for real ML processing per row
  -- Dear ML Engineer who's gonna read this,
  -- Feel free to train your model inside this function.
  -- Each file will be received, printing them will show
  -- their format.
  print(file);
end


-- Handle whole file row-by-row
function handleTrainRows(content)
  local csv_rows = ftcsv.parse(content, ",", {loadFromString=true, headers=true})
  for i, row in ipairs(csv_rows) do
    handleTrainRow(row);
  end
end

-- Handle whole file row-by-row
function handleInputRows(content)
  local csv_rows = ftcsv.parse(content, ",", {loadFromString=true, headers=true})
  for i, row in ipairs(csv_rows) do
    handleInputRow(row);
  end
end


app.get('/', function(req, res)
   res.send('Hello from our LuaJIT/Torch microservice!')
   end)

app.post('/train', function(req, res)
  if req.body then
    if req.body.files and type(req.body.files) == 'table' then
      for i, s3file in ipairs(req.body.files) do
        print("Training file: " .. s3file .. "...")
        handleTrainFile(bucket:get(s3file))
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
        print("Input file: " .. s3file .. "...")
        handleInputFile(bucket:get(s3file))
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
        print("Output file: " .. s3file .. "...")
        output = handleOutputFile(bucket:get(s3file))
      end
      res.json(output)
    end
  end
  res.status(500).send("Bad POST /output request, need 'files : [ <s3 path>, ...]' in the body")
  end)

app.listen({host = '0.0.0.0', port=8080})

