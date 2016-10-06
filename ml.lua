-- Created by Lef, UnifyID
-- Handle your ML state here.

-- Local module
local M ={}

function M.handleOutputFile(filename, content)
  -- TODO: Placeholder for real ML processing
  -- Dear ML Engineer who's gonna read this,
  -- Feel free to use your model to return the
  -- output vector of your model.
  print("Output file: " .. filename .. "...")
  return 42
end

function M.handleTrainFile(filename, content)
  -- TODO: Placeholder for real ML processing per row
  -- Dear ML Engineer who's gonna read this,
  -- Feel free to train your model inside this function.
  -- Each file will be received, printing them will show
  -- their format.
  print("Training file: " .. filename .. "...")
  print(filecontent)
end

function M.handleInputFile(filename, content)
  -- TODO: Placeholder for real ML processing per row
  -- Dear ML Engineer who's gonna read this,
  -- Feel free to train your model inside this function.
  -- Each file will be received, printing them will show
  -- their format.
  print("Input file: " .. filename .. "...")
  print(filecontent)
end

return M
