local BUILTIN_TASKS = require("builtins.taskrunner.tasks").filetypes
local PROJECT_TASKS = require("builtins.taskrunner.tasks").projects

local H = require("builtins.taskrunner.helpers")

local M = {}

M.load_tasks = function()
  local tasks = {}
  if H.file_exists("tasks.lua") then
    if package.loaded.tasks then
      package.loaded.tasks = nil
    end

    local ok, result = pcall(require, "tasks")
    if not ok then
      H.notify("Error loading tasks.lua:\n" .. result, "error")
    end
    tasks = result
  end

  return vim.tbl_deep_extend("force", BUILTIN_TASKS, tasks)
end

M.get_ft_tasks = function(tasks)
  local ext = vim.fn.expand("%:r")
  local ft = vim.bo.filetype

  if not tasks[ft] then
    for lang, extension in pairs(tasks["ft_mappings"] or {}) do
      if vim.tbl_contains(extension, ext) then
        ft = lang
        break
      end
    end
  end
  ft = ft or ext

  local default_tasks = tasks["default"] or {}
  local ft_tasks = tasks[ft] or {}

  local all_tasks = vim.tbl_deep_extend("force", default_tasks, ft_tasks)

  local selected = nil
  for _, info in pairs(PROJECT_TASKS) do
    for _, marker in ipairs(info.root_markers) do
      if H.file_exists(marker) then
        if not selected or (info.priority or 0) > (selected.priority or 0) then
          selected = info
        end
        break
      end
    end
  end

  if selected then
    for name, task in pairs(selected.tasks) do
      all_tasks[name] = task
    end
  end

  if vim.tbl_isempty(all_tasks) then
    H.notify("No tasks found for " .. ft, "info")
    return nil
  end

  return all_tasks
end

M.get_task_command = function(task_name, task)
  local cmd = task["cmd"]
  local args = task["args"] or ""

  if not cmd then
    H.notify("No command found for task " .. task_name, "error")
    return nil
  end

  local command = cmd .. (args ~= "" and " " .. args or "")

  return vim.fn.expandcmd(command)
end

M.run_task = function(task_name, tasks)
  local task = tasks[task_name]

  local prelaunch_task = task["prelaunch"]
  local prelaunch_cmd = nil
  if prelaunch_task then
    if not tasks[prelaunch_task] then
      H.notify("Prelaunch task " .. prelaunch_task .. " not found", "error")
      return
    end
    prelaunch_cmd = M.get_task_command(prelaunch_task, tasks[prelaunch_task])
  end

  local cmd = M.get_task_command(task_name, task)
  if not cmd then
    return
  end

  if string.sub(cmd, 1, 1) == "!" then
    vim.cmd(string.sub(cmd, 2, -1))
    return true
  end

  cmd = "echo RUN: '" .. cmd .. "' && " .. cmd

  if prelaunch_cmd then
    cmd = 'echo RUN: "' .. prelaunch_cmd .. '" && ' .. prelaunch_cmd .. " && " .. cmd
  end

  Snacks.terminal.toggle(cmd, {
    cwd = vim.fn.getcwd(),
    auto_close = false,
  })
end

M.select_and_run_task = function(ft_tasks)
  local tasks_list = {}

  for task_name, _ in pairs(ft_tasks) do
    table.insert(tasks_list, task_name)
  end

  table.sort(tasks_list)

  vim.ui.select(tasks_list, {
    prompt = "Select task to run",
  }, function(task_name)
    if task_name then
      M.run_task(task_name, ft_tasks)
    end
  end)
end

vim.api.nvim_create_user_command("Task", function(opts)
  local task_name = opts.args

  local tasks = M.load_tasks()
  if not tasks then
    return
  end

  local ft_tasks = M.get_ft_tasks(tasks)
  if not ft_tasks then
    return
  end

  if not task_name or not ft_tasks[task_name] then
    M.select_and_run_task(ft_tasks)
    return
  end

  M.run_task(task_name, ft_tasks)
end, { nargs = "?" })
