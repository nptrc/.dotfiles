require("mini.surround").setup()

require("mini.bufremove").setup()
vim.keymap.set("n", "<leader>bd", "<cmd>lua MiniBufremove.delete(0, true)<cr>")

require("mini.files").setup()
vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>")

local ai = require("mini.ai")
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    o = ai.gen_spec.treesitter({ -- code block
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
    d = { "%f[%d]%d+" }, -- digits
    e = { -- Word with case
      { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
      "^().*()$",
    },
    u = ai.gen_spec.function_call(), -- u for "Usage"
    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
  },
})

require("mini.pick").setup({
  mappings = {
    toggle_info = "<tab>",
    toggle_preview = "<c-p>",
    move_down = "<c-j>",
    move_up = "<c-k>",
  },
})
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<cr>")
vim.keymap.set("n", "<leader>sg", "<cmd>Pick grep_live<cr>")
vim.keymap.set("n", "<leader>sh", "<cmd>Pick help<cr>")
