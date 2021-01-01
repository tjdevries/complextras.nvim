RELOAD('docgen')

local docgen = require('docgen')

local docs = {}

docs.test = function()
  -- local input_dir = "./lua/complextras.lua"
  -- local input_files = vim.fn.globpath(input_dir, "**/*.lua", false, true)

  local input_files = { "./lua/complextras.lua" }

  local output_file = "./docs/complextras.txt"
  local output_file_handle = io.open(output_file, "w")

  for _, input_file in ipairs(input_files) do
    docgen.write(input_file, output_file_handle)
  end

  output_file_handle:write(" vim:tw=78:ts=8:ft=help:norl:")
  output_file_handle:close()
  vim.cmd [[checktime]]
end

docs.test()

return docs
