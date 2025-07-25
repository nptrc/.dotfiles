later(function()
  add("mfussenegger/nvim-dap")

  local dap = require("dap")

  local map = vim.keymap.set
  -- stylua: ignore start
  map("n", "<leader>dc", "<cmd>DapContinue<cr>", { desc = "Run/Continue" })
  map("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle Breakpoint" })
  map("n", "<leader>dC", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
  map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run to Cursor" })
  map("n", "<leader>dt", "<cmd>DapTerminate<cr>", { desc = "Terminate" })
  map("n", "<leader>du", "<cmd>DapViewToggle<cr>", { desc = "Toggle UI" })
  map("n", "<f10>", "<cmd>DapStepOver<cr>", { desc = "Step Over" })
  map("n", "<f11>", "<cmd>DapStepInto<cr>", { desc = "Step Into" })
  map("n", "<f12>", "<cmd>DapStepOut<cr>", { desc = "Step Out" })
  -- stylua: ignore end

  dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
  }

  dap.adapters.codelldb = {
    type = "executable",
    command = "codelldb",
  }

  dap.configurations.c = {
    {
      name = "Launch",
      type = "gdb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
    },
  }
  dap.configurations.cpp = dap.configurations.c

  add("mfussenegger/nvim-dap-python")
  local python_path = (function()
    local cwd = vim.fn.getcwd()
    if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
      return cwd .. "/venv/bin/python"
    elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
      return cwd .. "/.venv/bin/python"
    else
      return "/usr/bin/python"
    end
  end)()
  require("dap-python").setup(python_path)

  add("theHamsta/nvim-dap-virtual-text")
  require("nvim-dap-virtual-text").setup()

  add("igorlfs/nvim-dap-view")
  local dap_view = require("dap-view")

  dap_view.setup({
    windows = {
      position = "right",
      height = 0.6,
      terminal = {
        width = 0.3,
        position = "below",
        start_hidden = false,
      },
    },
    auto_toggle = true,
  })

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dap_view.open({})
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dap_view.close({})
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dap_view.close({})
  end
end)
