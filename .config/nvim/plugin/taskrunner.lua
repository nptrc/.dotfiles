if vim.g.loaded_taskrunner_plugin then
  return
end
vim.g.loaded_taskrunner_plugin = true

local TASKS_FILE = vim.fs.normalize("tasks.lua")
local FILENAME_PATTERNS = {
  WORKSPACE_FOLDER = {
    pattern = "${workspaceFolder}",
    replacement = vim.fn.getcwd(),
    desc = "Current working directory path",
  },
  WORKSPACE_FOLDER_BASE_NAME = {
    pattern = "${workspaceFolder}",
    replacement = vim.fn.getcwd():match("[^/]+$"),
    desc = "Current working directory name",
  },
  FILE = {
    pattern = "${file}",
    modifier = "%:p",
    desc = "Currently opened file",
  },
  FILE_RELATIVE = {
    pattern = "${relativeFile}",
    modifier = "%:p:.",
    desc = "Currently opened file relative to workspaceFolder",
  },
  FILE_BASE_NAME = {
    pattern = "${fileBasename}",
    modifier = "%:t",
    desc = "Currently opened file's basename",
  },
  FILE_BASE_NAME_NO_EXT = {
    pattern = "${fileBasenameNoExtension}",
    modifier = "%:t:r",
    desc = "Currently opened file's basename with no file extension",
  },
  FILE_EXT_NAME = {
    pattern = "${fileExtname}",
    modifier = "%:e",
    desc = "Currently opened file's extension",
  },
}
local FILETYPE_MAP = {
  -- Python
  py = "python",
  pyi = "python",
  pyc = "python",
  pyd = "python",
  pyw = "python",

  -- Rust
  rs = "rust",
  cargo = "rust",

  -- Assembly
  s = "asm",
  asm = "asm",
  nasm = "asm",

  -- C/C++
  h = "c",
  hpp = "cpp",

  -- C#
  cs = "csharp",

  -- Ruby
  rb = "ruby",
  erb = "ruby",

  -- Shell scripts
  sh = "shell",
  bash = "shell",
  zsh = "shell",

  -- Markdown
  md = "markdown",

  -- Kotlin
  kt = "kotlin",
  kts = "kotlin",

  -- Docker
  dockerfile = "docker",
  dockerignore = "docker",
}

---@param path string path to file
---@return boolean
local function file_exists(path)
  local cwd = vim.uv.cwd()
  return vim.fn.filereadable(cwd .. "/" .. path) == 1
end

---Echo a message to the user
---@param msg string The message to display
---@param type? string The highlight group to use
local function echo_message(msg, type)
  if type == "Error" then
    vim.api.nvim_notify(msg, vim.log.levels.ERROR, {})
  elseif type == "Info" then
    vim.api.nvim_notify(msg, vim.log.levels.INFO, {})
  else
    vim.api.nvim_echo({ { msg, "Normal" } }, true, {})
  end
end

---Get information about the current file
---@return table
local function get_current_file_info()
  local file_info = {}
  for pattern, info in pairs(FILENAME_PATTERNS) do
    file_info[pattern] = info.replacement or vim.fn.expand(info.modifier)
  end
  return file_info
end

---@class TaskRunner
local TaskRunner = {}
TaskRunner.__index = TaskRunner

---Create a new TaskRunner instance
---@return TaskRunner
function TaskRunner.new()
  local self = setmetatable({}, TaskRunner)
  return self
end

---Load tasks from tasks.lua file
---@return table?
function TaskRunner:load_tasks()
  if not file_exists(TASKS_FILE) then
    echo_message("tasks.lua file not found", "Error")
    return nil
  end

  if package.loaded.tasks then
    package.loaded.tasks = nil
  end

  local ok, result = pcall(require, "tasks")
  if not ok then
    echo_message("Error loading tasks.lua:\n" .. result, "Error")
    return nil
  end

  return result
end

---Get tasks for the current file
---@param file_info table The current file information
---@param tasks table The tasks table
---@return table?
function TaskRunner:get_ft_tasks(file_info, tasks)
  local filetype_map = vim.tbl_deep_extend("force", FILETYPE_MAP, tasks.ft_mappings or {})
  local ft = filetype_map[file_info["FILE_EXT_NAME"]] or file_info["FILE_EXT_NAME"]
  local ft_tasks = tasks[ft]
  local all_tasks = vim.tbl_extend("force", tasks.all or {}, ft_tasks or {})
  if vim.tbl_isempty(all_tasks) then
    echo_message("No tasks found for " .. file_info["FILE_EXT_NAME"], "Error")
    return nil
  end
  return all_tasks
end

---Prepare a command to run
---@param command string The command to prepare
---@return string, nil
function TaskRunner:prepare_command(command)
  local file_info = get_current_file_info()
  for pattern, info in pairs(FILENAME_PATTERNS) do
    command = command:gsub(info.pattern, file_info[pattern])
  end
  return command
end

---Get the command to run a task
---@param task table The task to run
---@return boolean?, string
function TaskRunner:get_task_command(task)
  if type(task) == "string" then
    echo_message("Task should be a table", "Error")
    return nil, ""
  end

  local cmd = task.cmd
  local cmd_args = task.args or ""
  local command = cmd .. " " .. cmd_args
  return true, self:prepare_command(command)
end

---Execute a command
---@param command string The command to execute
---@param term boolean Whether to run the command in a terminal
---@param no_echo? boolean Whether to echo the output
---@return boolean?
function TaskRunner:execute_command(command, term, no_echo)
  if command:sub(1, 1) == "!" then
    vim.cmd(command:sub(2, command:len() - 1))
    return true
  end

  if term == true then
    Snacks.terminal.toggle(command, {
      cwd = vim.uv.cwd(),
      auto_close = false,
    })
    return true
  end

  local output = vim.fn.system(command)
  local success = vim.v.shell_error == 0

  if success and not no_echo then
    echo_message(output == "" and "Task completed successfully" or "\n" .. output, "Info")
  elseif not success then
    echo_message("Error running command: " .. command .. "\n" .. output, "Error")
    return nil
  end

  return success
end

---Run a task
---@param ft_task table The task to run
---@param task_name string The name of the task
function TaskRunner:run_task(ft_task, task_name, is_prelaunch)
  local visited = self.visited or {}
  self.visited = visited

  if visited[task_name] then
    echo_message("Circular prelaunch detected for task: " .. task_name, "Error")
    self.visited = nil
    return
  end

  visited[task_name] = true

  local task = ft_task[task_name]

  if task.prelaunch then
    local ok = self:run_task(ft_task, task.prelaunch, true)
    if not ok then
      echo_message("Prelaunch task failed", "Error")
      self.visited = nil
      return
    end
  end

  local command_ok, command = self:get_task_command(task)
  if not command_ok then
    self.visited = {}
    return
  end

  if not is_prelaunch then
    self:execute_command(command, task.term == nil and true or task.term)
  else
    return self:execute_command(command, false, true)
  end

  self.visited = {}
end

---Select and run a task
---@param ft_tasks table The tasks for the current file
function TaskRunner:select_and_run_task(ft_tasks)
  local tasks_list = {}

  for task_name, _ in pairs(ft_tasks) do
    table.insert(tasks_list, task_name)
  end

  vim.ui.select(tasks_list, {
    prompt = "Select a task to run",
  }, function(task)
    if task then
      self:run_task(ft_tasks, task)
    end
  end)
end

local taskrunner = TaskRunner.new()

vim.api.nvim_create_user_command("Task", function(opts)
  local task_name = opts.args

  local tasks = taskrunner:load_tasks()
  if not tasks then
    return
  end

  local file_info = get_current_file_info()
  local ft_tasks = taskrunner:get_ft_tasks(file_info, tasks)
  if not ft_tasks then
    return
  end

  if not task_name or not ft_tasks[task_name] then
    taskrunner:select_and_run_task(ft_tasks)
    return
  end

  taskrunner:run_task(ft_tasks, task_name)
end, {
  nargs = "?",
  complete = function(arg_lead)
    local tasks = taskrunner:load_tasks()
    if not tasks then
      return {}
    end

    local file_info = get_current_file_info()
    local ft_tasks = taskrunner:get_ft_tasks(file_info, tasks)
    if not ft_tasks then
      return {}
    end

    local completions = {}

    for task_name, _ in pairs(ft_tasks) do
      if task_name:lower():find(arg_lead:lower(), 1, true) then
        table.insert(completions, task_name)
      end
    end

    return completions
  end,
})
