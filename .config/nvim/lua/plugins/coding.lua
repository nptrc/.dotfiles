return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      opts.mapping = cmp.mapping.preset.insert(vim.tbl_extend("force", opts.mapping, {
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      }))

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }

      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          local icons = LazyVim.config.icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind]
          end
          item.menu = ({
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            path = "[Path]",
            snippets = "[Snips]",
          })[entry.source.name]

          local widths = {
            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 25,
            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
          }

          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
              item[key] = vim.fn.strcharpart(item[key], 0, width) .. "…"
            end
          end

          return item
        end,
      }
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
    },

    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      npairs.setup(opts)

      local function rule(a1, ins, a2, lang)
        npairs.add_rule(Rule(ins, ins, lang)
          :with_pair(function(rule_opts)
            return a1 .. a2 == rule_opts.line:sub(rule_opts.col - #a1, rule_opts.col + #a2 - 1)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(rule_opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            return a1 .. ins .. ins .. a2 == rule_opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
          end))
      end

      rule("(", " ", ")")
      rule("{", " ", "}")
      rule("[", " ", "]")
    end,
  },
}
