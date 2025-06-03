local DEFAULT_TASKS = require("builtins.taskrunner.tasks").filetypes
local PROJECT_TASKS = require("builtins.taskrunner.tasks").projects

local H = require("builtins.taskrunner.helpers")

local PLACEHOLDER_PATTERNS = {
  WORKSPACE_FOLDER = {
    replacement = vim.fn.getcwd(),
    desc = "Current working directory path",
  },
  WORKSPACE_FOLDER_BASE_NAME = {
    replacement = vim.fn.getcwd():match("[^/]+$"),
    desc = "Current working directory name",
  },
  FILE = {
    modifier = "%:p",
    desc = "Currently opened file",
  },
  FILE_RELATIVE = {
    modifier = "%:p:.",
    desc = "Currently opened file relative to workspaceFolder",
  },
  FILE_BASE_NAME = {
    modifier = "%:t",
    desc = "Currently opened file's basename",
  },
  FILE_BASE_NAME_NO_EXT = {
    modifier = "%:t:r",
    desc = "Currently opened file's basename with no file extension",
  },
  FILE_EXT_NAME = {
    modifier = "%:e",
    desc = "Currently opened file's extension",
  },
}

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

  return vim.tbl_deep_extend("force", DEFAULT_TASKS, tasks)
end

M.get_current_file_info = function()
  local file_info = {}
  for placeholder, info in pairs(PLACEHOLDER_PATTERNS) do
    file_info[placeholder] = info.replacement or vim.fn.expand(info.modifier)
  end
  return file_info
end

M.get_ft_tasks = function(tasks)
  local file_info = M.get_current_file_info()
  local ext = file_info["FILE_EXT_NAME"]
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

  local global_tasks = tasks["global"] or {}
  local ft_tasks = tasks[ft] or {}

  local all_tasks = vim.tbl_deep_extend("force", global_tasks, ft_tasks)

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

  M.env = tasks["env"] or {}
  M.term_opts = tasks["term_opts"] or {}
  return all_tasks
end

M.get_task_command = function(task_name, task)
  local file_info = M.get_current_file_info()
  local cmd = task["cmd"]
  local args = task["args"] or ""

  if not cmd then
    H.notify("No command found for task " .. task_name, "error")
    return nil
  end

  local command = cmd .. (args ~= "" and " " .. args or "")

  command = string.gsub(command, "(%${.-})", function(key)
    key = string.sub(key, 3, -2)
    local value = file_info[key]
    if not value and string.find(key, "env%.") then
      key = string.sub(key, 5, -1)
      value = M.env[key]
      if not value then
        H.notify("Undefined placeholder: " .. key, "warn")
        return ""
      end
    end
    return value
  end)

  return command
end

M.execute_command = function(cmd, term, is_prelaunch)
  if string.sub(cmd, 1, 1) == "!" then
    vim.cmd(string.sub(cmd, 2, -1))
    return true
  end

  if term == true then
    Snacks.terminal.toggle(cmd, {
      cwd = vim.uv.cwd(),
      auto_close = false,
      win = M["term_opts"],
    })
    return true
  end

  local output = vim.fn.systemlist(cmd)
  local success = vim.v.shell_error == 0

  if success and not is_prelaunch then
    if output == "" then
      H.notify("Task run successfully", "info")
    else
      vim.fn.setqflist({}, "r", { lines = output })
      vim.cmd("copen")
    end
  elseif not success then
    vim.fn.setqflist({}, "r", { lines = output })
    vim.cmd("copen")
    return nil
  end

  return success
end

M.run_task = function(task_name, tasks, is_prelaunch)
  local visited = M.visited or {}
  M.visited = visited

  if visited[task_name] then
    H.notify("Circular prelaunch detected for task: " .. task_name, "Error")
    M.visited = nil
    return nil
  end
  visited[task_name] = true

  local task = tasks[task_name]

  local prelaunch_task = task.prelaunch
  if prelaunch_task then
    if not tasks[prelaunch_task] then
      H.notify("Prelaunch task " .. prelaunch_task .. " not found", "error")
      return
    end
    if not M.run_task(prelaunch_task, tasks, true) then
      M.visited = nil
      return
    end
  end

  local cmd = M.get_task_command(task_name, task)
  if not cmd then
    M.visited = nil
    return nil
  end

  if not is_prelaunch then
    M.execute_command(cmd, task.term == nil and true or task.term)
    M.visited = {}
    return
  else
    return M.execute_command(cmd, false, is_prelaunch)
  end
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
