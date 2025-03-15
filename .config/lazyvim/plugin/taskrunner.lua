if vim.g.loaded_taskrunner_plugin then
  return
end
vim.g.loaded_taskrunner_plugin = true

local TASKS_FILE = vim.fs.normalize("tasks.lua")
local FILENAME_PATTERNS = {
  FILE = "${file}", -- absolute path to file
  FILE_NO_EXT = "${fileNoExt}", -- absolute path to file without extension
  FILE_NAME = "${fileName}", -- only the file name
  FILE_NAME_NO_EXT = "${fileNameNoExt}", -- only the file name without extension
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
  cc = "cpp",
  cxx = "cpp",
  hpp = "cpp",
  hxx = "cpp",

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
---@param highlight? string The highlight group to use
---@param history? boolean Whether to add the message to the command history
local function echo_message(msg, highlight, history)
  vim.api.nvim_echo({ { "[Task] " .. msg, highlight or "Normal" } }, history or true, {})
end

---Get information about the current file
---@return table
local function get_current_file_info()
  local file = vim.fn.expand("%:p")
  return {
    file = file,
    fileNoExt = vim.fn.fnamemodify(file, ":r"),
    fileName = vim.fn.fnamemodify(file, ":t"),
    fileNameNoExt = vim.fn.fnamemodify(file, ":t:r"),
    extension = vim.fn.fnamemodify(file, ":e"),
  }
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
  local ft = filetype_map[file_info.extension] or file_info.extension
  local ft_tasks = tasks[ft]
  local all_tasks = vim.tbl_extend("force", tasks.all or {}, ft_tasks or {})
  if vim.tbl_isempty(all_tasks) then
    echo_message("No tasks found for " .. file_info.extension, "Error")
    return nil
  end
  return all_tasks
end

---Prepare a command to run
---@param command string The command to prepare
---@return string, nil
function TaskRunner:prepare_command(command)
  local file_info = get_current_file_info()
  return command
    :gsub(FILENAME_PATTERNS.FILE, file_info.file)
    :gsub(FILENAME_PATTERNS.FILE_NO_EXT, file_info.fileNoExt)
    :gsub(FILENAME_PATTERNS.FILE_NAME, file_info.fileName)
    :gsub(FILENAME_PATTERNS.FILE_NAME_NO_EXT, file_info.fileNameNoExt)
end

---Get the command to run a task
---@param task table The task to run
---@return string
function TaskRunner:get_task_command(task)
  if type(task) == "string" then
    task = { cmd = task }
  end

  local cmd = task.cmd
  local cmd_args = task.args or ""
  local command = cmd .. " " .. cmd_args
  return self:prepare_command(command)
end

---Execute a command
---@param command string The command to execute
---@param term boolean Whether to run the command in a terminal
---@return boolean?
function TaskRunner:execute_command(command, term)
  if command:sub(1, 1) == "!" then
    vim.cmd(command:sub(2, command:len() - 1))
    return true
  end

  if term == true then
    vim.cmd("sp | term " .. command)
    vim.cmd("setlocal nobuflisted bufhidden=wipe")
    vim.cmd("startinsert")
    return true
  end

  local output = vim.fn.system(command)
  if vim.v.shell_error == 0 then
    if output == "" then
      echo_message("Task completed successfully")
    else
      echo_message("\n" .. output)
    end
    return true
  else
    echo_message("Error running command: " .. command .. "\n" .. output, "Error")
    return nil
  end
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

  local command = self:get_task_command(task)

  if not is_prelaunch then
    self:execute_command(command, task.term == nil and true or task.term)
  else
    return self:execute_command(command, false)
  end

  self.visited = {}
end

---Select and run a task
---@param ft_tasks table The tasks for the current file
function TaskRunner:select_and_run_task(ft_tasks)
  local tasks_list = {}

  for task_name, task_data in pairs(ft_tasks) do
    local task_desc = ""
    if task_data.desc then
      task_desc = "(" .. task_data.desc .. ")"
    end

    table.insert(tasks_list, {
      name = task_name,
      desc = task_desc,
    })
  end

  table.sort(tasks_list, function(a, b)
    return a.name < b.name
  end)

  vim.ui.select(tasks_list, {
    prompt = "Select a task to run",
    format_item = function(item)
      return item.name .. " " .. item.desc
    end,
  }, function(task)
    if task then
      self:run_task(ft_tasks, task.name)
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
