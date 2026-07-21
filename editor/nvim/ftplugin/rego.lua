vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format Rego code on save using opa fmt",
  buffer = 0,
  group = vim.api.nvim_create_augroup('rego_format', { clear = true }),
  callback = function(ev)
    local buf = ev.buf
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local text = table.concat(lines, "\n")

    -- Run 'opa fmt' synchronously on the buffer contents
    local obj = vim.system({'opa', 'fmt'}, { text = true, stdin = text }):wait()

    if obj.code == 0 and obj.stdout ~= "" then
      local new_lines = vim.split(obj.stdout, "\n")
      -- Remove the trailing newline that split() introduces at the end of output
      if new_lines[#new_lines] == "" then table.remove(new_lines) end

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
    else
      vim.notify("Rego format failed: " .. (obj.stderr or "Unknown error"), vim.log.levels.WARN)
    end
  end,
})
