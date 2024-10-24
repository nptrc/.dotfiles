local M = {}

M.code_runner = function()
  local file = vim.fn.expand "%"
  local file_no_ext = vim.fn.expand "%:r"

  local ft_cmds = {
    python = "python3 " .. file,
    c = "gcc -o " .. file_no_ext .. " -g " .. file .. " -Wall && ./" .. file_no_ext,
    cpp = "g++ -o " .. file_no_ext .. " -g " .. file .. " -Wall && ./" .. file_no_ext,
  }

  if ft_cmds[vim.bo.ft] then
    require("nvchad.term").runner {
      pos = "sp",
      id = "code_runner",
      clear_cmd = false,
      cmd = function()
        return ft_cmds[vim.bo.ft]
      end,
    }
  end
end

return M
