ML Microservice in Torch
---------------------------

Simple Waffle web server implementing the following REST API.

## Introduction

The Torch scientific library has some exceptional ML libraries. To facilitate using them I have
written a simple REST API that should work for most ML models, as well as a Docker container
around the whole thing.

## Usage

### Docker

*Build*: `docker build -t lua-ml-microservice .`
*Run*: `docker run -it lua-ml-microservice`

### Host

*Run*: `th app.lua`

### Configure
Edit app.lua to add your AWS credentials and handlers for your ML model.
```
local bucket = s3:connect{
  awsId="<Your AWS ID here>",
  awsKey="<Your AWS Secret Key here>",
  bucket="<target bucket name here>",
}
```

And to handle each file passed in the POST request edit `ml.lua`:
```
function M.handleTrainFile(file)
  -- TODO: Placeholder for real ML processing per row
  -- Dear ML Engineer who's gonna read this,
  -- Feel free to train your model inside this function.
  -- Each file will be received, printing them will show
  -- their format.
  print(file);
end
```

## REST API

### POST /train

Body:
```
{
  files: [ <S3 file path>, ...]
}
```

Example:
```
{
  files: [ 32AD86AB68CB4368830506D352772A12/bluetooth/490569736771195.csv ]
}
```

Error: *500*

### POST /input

Body:
```
{
  files: [ <S3 file path>, ... ]
}
```

Error: *500*

### POST /output/

Body:
```
{
  files: [ <s3 file path>, ... ]
}

```

Response:
```
{
  output: { output vector }
}
```

Error: *500*

