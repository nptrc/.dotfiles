local cmp = require "cmp"
local conf = require "nvchad.configs.cmp"

conf.mapping = vim.tbl_deep_extend("force", conf.mapping, {
  ["<C-j>"] = cmp.mapping.select_next_item(),
  ["<C-k>"] = cmp.mapping.select_prev_item(),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if require("luasnip").expand_or_jumpable() then
      require("luasnip").expand_or_jump()
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if require("luasnip").jumpable(-1) then
      require("luasnip").jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
})

return conf
