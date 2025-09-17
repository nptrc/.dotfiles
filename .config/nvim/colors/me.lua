local c = {
  bg = "#1d1f21",
  fg = "#c5c8c6",
  base0 = "#282a2e",
  base1 = "#a54242",
  base2 = "#8c9440",
  base3 = "#de935f",
  base4 = "#5f819d",
  base5 = "#85678f",
  base6 = "#5e8d87",
  base7 = "#707880",
  base8 = "#373b41",
  base9 = "#cc6666",
  base10 = "#b5bd68",
  base11 = "#f0c674",
  base12 = "#81a2be",
  base13 = "#b294bb",
  base14 = "#8abeb7",
  base15 = "#c5c8c6",
}

local hl = {
  ["Normal"] = { bg = c.bg, fg = c.fg },
  ["NormalFloat"] = { bg = c.bg, fg = c.fg },
  ["StatusLine"] = {},
  ["Directory"] = { fg = c.base4 },

  ["Constant"] = { fg = c.base10 },
  ["String"] = { link = "Constant" },
  ["Character"] = { link = "Constant" },
  ["Identifier"] = {},
  ["Function"] = {},
  ["Statement"] = { fg = c.base11 },
  ["Operator"] = { fg = c.base17 },
  ["PreProc"] = { fg = c.base11 },
  ["Type"] = { fg = c.base11 },
  ["Special"] = { fg = c.base11 },

  ["@constructor.lua"] = { fg = c.base15 },

  ["@string.escape.c"] = { link = "Constant" },
  ["@lsp.type.macro.c"] = { link = "Special" },
  ["@punctuation.bracket.c"] = { fg = c.base15 },

  ["@module.python"] = { fg = c.base15 },

  ["SnacksPickerDir"] = { fg = c.fg },
  ["SnacksPickerPathHidden"] = { fg = c.base7 },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end
