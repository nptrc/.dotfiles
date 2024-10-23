local map = vim.keymap.set

local function code_runner()
  require("nvchad.term").runner {
    pos = "sp",
    id = "code_runner",
    clear_cmd = false,
    cmd = function()
      local file = vim.fn.expand "%"
      local file_no_ext = vim.fn.expand "%:r"

      local ft_cmds = {
        python = "python3 " .. file,
        c = "gcc -o " .. file_no_ext .. " -g " .. file .. " -Wall && ./" .. file_no_ext,
        cpp = "g++ -o " .. file_no_ext .. " -g " .. file .. " -Wall && ./" .. file_no_ext,
      }

      return ft_cmds[vim.bo.ft]
    end,
  }
end

map("n", "<C-b>", code_runner)
