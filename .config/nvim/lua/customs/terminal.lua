local M = {}

local terminals = {}

M.default_opts = {
  position = "float",
  width = 0.8,
  height = 0.8,
  border = "single",
}

M.open = function(cmd, opts)
  opts = vim.tbl_extend("force", M.default_opts, opts or {})

  opts.width = math.ceil(opts.width * vim.o.columns)
  opts.height = math.ceil(opts.height * vim.o.lines)

  if not cmd then
    cmd = vim.o.shell
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local newbuf = true
  for k, v in pairs(terminals) do
    if k == cmd and vim.api.nvim_buf_is_valid(v.buf) then
      buf = v.buf
      newbuf = false
    end
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    style = "minimal",
    row = (vim.o.lines - opts.height) / 2 - 1,
    col = (vim.o.columns - opts.width) / 2,
    width = opts.width,
    height = opts.height,
    border = opts.border,
  })

  if newbuf == true then
    vim.api.nvim_buf_call(buf, function()
      vim.fn.jobstart(cmd, {
        cwd = opts.cwd,
        env = opts.env,
        term = true,
        on_stdout = opts.on_stdout,
        on_exit = opts.on_exit,
        on_stderr = opts.on_stderr,
      })
    end)

    vim.bo[buf].buflisted = false

    vim.keymap.set("n", "q", function()
      vim.api.nvim_win_close(win, true)
    end, { buffer = buf })
  end

  vim.cmd("startinsert")

  terminals[cmd] = { buf = buf, win = win }
end

M.toggle = function(cmd, opts)
  if not terminals[cmd] then
    M.open(cmd, opts)
  else
    if vim.api.nvim_win_is_valid(terminals[cmd].win) then
      vim.api.nvim_win_close(terminals[cmd].win, true)
    else
      M.open(cmd, opts)
    end
  end
end

return M
