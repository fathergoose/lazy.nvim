local M = {}

-- After realizing I had composed and sent a message to a recruiter where I
-- botched copying the content into an email by deleting newlines without
-- replacing them with spaces.
M.export_md_to_clipboard = function()
  -- Get contents of current buffer
  local curr_bufnr = vim.api.nvim_get_current_buf()
  local curr_buf_content = vim.api.nvim_buf_get_lines(curr_bufnr, 0, -1, false)

  -- Remove Markdown Main Header
  local lines_to_export = {}
  for _, line in ipairs(curr_buf_content) do
    if line:find("^# .*$") then
    else
      lines_to_export[#lines_to_export + 1] = line
    end
  end

  -- Join lines with a space
  local curr_buf_content_str = table.concat(lines_to_export, " ")

  -- Remove leading whitespace
  local trimmed_string = curr_buf_content_str:gsub("^%s+", "")

  -- At this point the former linebreak formatting has been replaced by a single space
  -- Paragraph breaks were orginally two new lines and are now double spaces
  -- Replace those double spaces with a double newline
  local multi_line_content = trimmed_string:gsub("  ", "\n\n")

  -- Send multi_line_content to the system clipboard
  vim.fn.setreg("*", multi_line_content)
end

M.toggle_copilot = function()
  if vim.g.copilot_enabled then
    vim.g.copilot_enabled = false
    vim.cmd("Copilot disable")
  else
    vim.g.copilot_enabled = true
    vim.cmd("Copilot enable")
  end
end
return M
