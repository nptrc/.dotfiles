local function clangd_cmd()
  local clangd_opts = { "clangd" }

  if os.getenv("IDF_PATH") then
    local home = vim.env.HOME
    local esp_clang = home .. "/.espressif/tools/esp-clang/"
    local scandir = vim.uv.fs_scandir(esp_clang)
    if scandir then
      local latest_clangd
      while true do
        local name = vim.uv.fs_scandir_next(scandir)
        if not name then
          break
        end
        if name:match("^esp%-.+") then
          latest_clangd = esp_clang .. name .. "/esp-clang/bin/clangd"
        end
      end
      clangd_opts = { latest_clangd, "--query-driver=**" }
    end
  end

  return vim.tbl_extend("keep", clangd_opts, {
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  })
end

_G.mason_tools = {
  lsp = {
    lua_ls = {
      mason = "lua-language-server",
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          doc = {
            privateName = { "^_" },
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library",
            },
          },
        },
      },
    },
    clangd = {
      cmd = clangd_cmd(),
      root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "Makefile",
        "CMakeLists.txt",
        "config.h.in",
        "configure.ac",
        "configure.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja",
        ".git",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
    },
  },

  formatters = {
    stylua = { ft = { "lua" } },
    ["clang-format"] = { ft = { "c", "cpp" } },
    cmake_format = {
      mason = "cmakelang",
      ft = { "cmake" },
    },
  },
}

require("mason").setup()
local mr = require("mason-registry")
mr.refresh(function()
  for _, packages in pairs(_G.mason_tools) do
    for package, opts in pairs(packages) do
      local p = mr.get_package(opts.mason or package)
      if not p:is_installed() then
        p:install()
      end
    end
  end
end)

for server, opts in pairs(_G.mason_tools.lsp) do
  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    local map = function(mode, lhs, rhs, opts)
      local map_opts = vim.tbl_extend("force", { buffer = args.buf }, opts or {})
      vim.keymap.set(mode, lhs, rhs, map_opts)
    end

    map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
    map("n", "grn", vim.lsp.buf.rename, { desc = "Rename" })
    map({ "n", "v" }, "gca", vim.lsp.buf.code_action, { desc = "Code Action" })
    map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
    map("n", "grr", vim.lsp.buf.references, { desc = "References" })
    map("n", "grt", vim.lsp.buf.type_definition, { desc = "Type Definition" })
    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, { desc = "Next Diagnostic" })
    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, { desc = "Previous Diagnostic" })

    if client:supports_method("textDocument/implementation") then
      map("n", "gri", vim.lsp.buf.implementation, { desc = "Implementation" })
    end

    vim.diagnostic.config({
      underline = false,
    })
  end,
})

local conform = {
  formatters_by_ft = {},
  formatters = {},
}
for formatter, opts in pairs(_G.mason_tools.formatters) do
  for _, v in pairs(opts.ft) do
    conform.formatters_by_ft[v] = { formatter }
  end

  if opts.settings then
    conform.formatters[formatter] = opts.settings
  end
end

require("conform").setup({
  formatters_by_ft = conform.formatters_by_ft,
  formatters = conform.formatters,
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
