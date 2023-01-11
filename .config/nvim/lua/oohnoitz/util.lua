local scopes = { o = vim.o, b = vim.bo, w = vim.wo, g = vim.g }

local M = {}

function M.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

return M
