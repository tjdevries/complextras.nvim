local Job = require("plenary.job")

---@brief [[
---  complextras is a plugin for adding a few extras to your |ins-completion| experience.
---
---   Made with love by TJ DeVries
---@brief ]]
---@tag complextras.nvim

-- TODO: Can we do this with libuv?? :) :) :) :) :)
--          @conni ??? :)
local do_grep = function(search)
  if vim.fn.executable('rg') == 1 then
    return Job:new {
      command = 'rg',
      args = {search, "-I"},
    }:sync()
  else
    return Job:new {
      command = 'grep',
      args = {search},
    }
  end
end

local complextras = {}

--- Complete any matching line from an open buffer.
--- Does not have to be an exact match, must just contain
--- all of the text _currently_ on your line.
complextras.complete_matching_line = function()
  local current_line = vim.api.nvim_get_current_line()
  current_line = vim.trim(current_line)

  if not current_line then
    print("You aren't on a line or something weird")
    return
  end

  local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local matching_lines = {}
  for _, v in ipairs(all_lines) do
    if string.find(v, current_line, 1, true) then
      table.insert(matching_lines, v)
    end
  end

  vim.fn.complete(1, matching_lines)

  return ''
end

--- Complete a line like ^x^l from anywhere in your current working directory.
--- Does not have to be an open file!
---@param current_line string: Optional line to match against. Defaults to your current line
complextras.complete_line_from_cwd = function(current_line)
  current_line = current_line or vim.trim(vim.api.nvim_get_current_line())

  if not current_line then
    print("You aren't on a line or something weird")
    return
  end

  local all_lines = do_grep(current_line)

  local uniq_lines = {}
  for _, v in ipairs(all_lines) do
    uniq_lines[v] = true
  end

  local matching_lines = {}
  for v, _ in pairs(uniq_lines) do
    if string.find(v, current_line, 1, true) then
      table.insert(matching_lines, v)
    end
  end

  vim.fn.complete(1, matching_lines)

  return ''
end

return complextras
