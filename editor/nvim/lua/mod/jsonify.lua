local json = require("mod/json")

local function unjsonify()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  local bufferText = table.concat(lines, "\n")

  local decoded = json.decode(bufferText)

  local replacement = {}
  for line in decoded:gmatch("[^\r\n]+") do
      table.insert(replacement, line)
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, true, replacement)
end

vim.api.nvim_create_user_command("Unjsonify", unjsonify, {})

local function jsonify()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  local bufferText = table.concat(lines, "\n")

  local encoded = json.encode(bufferText)

  vim.api.nvim_buf_set_lines(0, 0, -1, true, { encoded })
end

vim.api.nvim_create_user_command("Jsonify", jsonify, {})
