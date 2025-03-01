if vim.g.loaded_tasks_plugin then
  return
end
vim.g.loaded_tasks_plugin = true

local TASKS_FILE = vim.fs.normalize("tasks.lua")
local FILENAME_PATTERNS = {
  FULL = "${fileName}",
  NO_EXT = "${fileNameNoExt}",
}
local FILETYPE_MAP = {
  py = "python",
}

---Check if a file exists
---@param filename string The file to check
---@return boolean
local function file_exists(filename)
  local cwd = vim.uv.cwd()
  if vim.fn.filereadable(cwd .. "/" .. filename) == 1 then
    return true
  end
  return false
end

---Echo a message to the user
---@param msg string The message to display
---@param highlight? string The highlight group to use
---@param history? boolean Whether to add the message to the command history
local function echo_message(msg, highlight, history)
  vim.api.nvim_echo({ { "[Task] " .. msg, highlight or "None" } }, history or true, {})
end

---Get information about the current file
---@return table
local function get_current_file_info()
  local full_path = vim.fn.expand("%:p:.")
  return {
    full_path = full_path,
    extension = vim.fn.fnamemodify(full_path, ":e"),
    no_ext = vim.fn.fnamemodify(full_path, ":r"),
  }
end

---@class TaskRunner The TaskRunner class
local TaskRunner = {}
TaskRunner.__index = TaskRunner

---Create a new TaskRunner instance
---@return TaskRunner
function TaskRunner.new()
  local self = setmetatable({}, TaskRunner)
  return self
end

---Load tasks from tasks.lua
---@return table?, string?
function TaskRunner:load_tasks()
  if not file_exists(TASKS_FILE) then
    return nil, "tasks.lua doesn't exist"
  end

  if package.loaded.tasks then
    package.loaded.tasks = nil
  end

  local ok, tasks = pcall(require, "tasks")
  if not ok then
    return nil, "Failed to load tasks module:\n" .. tasks
  end
  return tasks
end

---Get tasks for the current filetype
---@param tasks table The tasks table
---@param file_info table The file information
---@return table?, string?
function TaskRunner:get_filetype_tasks(tasks, file_info)
  local filetype_mappings_from_tasks = tasks.filetype_mappings or {}
  if type(filetype_mappings_from_tasks) ~= "table" then
    filetype_mappings_from_tasks = {}
  end

  local merged_filetype_map = vim.tbl_deep_extend("force", {}, FILETYPE_MAP, filetype_mappings_from_tasks)

  local filetype = merged_filetype_map[file_info.extension] or file_info.extension
  local filetype_tasks = tasks[filetype]
  local all_tasks = tasks["all"]

  if not filetype_tasks and not all_tasks then
    return nil, "Can't find any tasks for current file"
  end

  if type(filetype_tasks) == "string" then
    filetype_tasks = { [file_info.extension] = filetype_tasks }
  elseif type(filetype_tasks) ~= "table" then
    filetype_tasks = {}
  end

  if type(all_tasks) == "string" then
    all_tasks = { all = all_tasks }
  elseif type(all_tasks) ~= "table" then
    all_tasks = {}
  end

  return vim.tbl_deep_extend("keep", filetype_tasks or {}, all_tasks or {})
end

---Prepare a command by replacing filename placeholders
---@param command string The command to prepare
---@param file_info table The file information
---@return string, nil
function TaskRunner:prepare_command(command, file_info)
  return command:gsub(FILENAME_PATTERNS.FULL, file_info.full_path):gsub(FILENAME_PATTERNS.NO_EXT, file_info.no_ext)
end

---Get the command to run for a task
---@param task table|string The task to get the command for
---@param file_info table The file information
---@return string
function TaskRunner:get_task_command(task, file_info)
  local command = type(task) == "table" and task.cmd or tostring(task)
  local args = type(task) == "table" and task.args or ""

  if #args > 0 then
    command = command .. " " .. args
  end

  return self:prepare_command(command, file_info)
end

---Execute a command
---@param command string The command to execute
---@param term? boolean Run command in terminal or not
---@return boolean, string?
function TaskRunner:execute_command(command, term)
  if command:sub(1, 1) == "!" then
    vim.cmd(command:sub(2))
    return true, nil
  end

  if term == true then
    vim.cmd("split | term " .. command)
    vim.cmd("startinsert")
    return true, nil
  end

  local output = vim.fn.system(command)
  return vim.v.shell_error == 0, output
end

---Display task execution output
---@param task_name string Name of the task
---@param msg_type string Type of message (e.g., "Prelaunch", "Main")
---@param msg string? The message content
---@param success boolean Whether the task succeeded
function TaskRunner:echo_task_output(task_name, msg_type, msg, success)
  if not msg or msg == "" then
    return
  end

  local highlight = success and "None" or "ErrorMsg"
  echo_message(msg_type .. " task '" .. task_name .. "' output:\n" .. msg, highlight)
end

---Execute a task
---@param task_name string The name of the task to execute
---@param available_tasks table The available tasks
---@param file_info table The file information
---@param is_prelaunch? boolean Whether this is a prelaunch
---@return boolean, string?
function TaskRunner:execute_task(task_name, available_tasks, file_info, is_prelaunch)
  local task = available_tasks[task_name]
  if not task then
    return false, "Task '" .. task_name .. "' not found"
  end

  local should_run = true
  if task.prelaunch then
    local prelaunch_ok, prelaunch_msg = self:execute_task(task.prelaunch, available_tasks, file_info, true)
    self:echo_task_output(task.prelaunch, "Prelaunch", prelaunch_msg, prelaunch_ok)
    should_run = prelaunch_ok
  end

  local command = self:get_task_command(task, file_info)

  if is_prelaunch == true then
    return self:execute_command(command)
  end

  if should_run then
    local ok, msg = self:execute_command(command, task.term == nil and true or task.term)
    self:echo_task_output(task_name, "Main", msg or "", ok)
  end

  return true, nil
end

---Select and run a task
---@param available_tasks table The available tasks
---@param file_info table The file information
function TaskRunner:select_and_run_task(available_tasks, file_info)
  local choices = {}

  for task_name, task_data in pairs(available_tasks) do
    local desc = ""

    if type(task_data) == "table" and task_data.desc then
      desc = task_data.desc
    end

    table.insert(choices, {
      value = task_name,
      display = task_name .. (desc ~= "" and " (" .. desc .. ")" or ""),
    })
  end

  table.sort(choices, function(a, b)
    return a.value < b.value
  end)

  vim.ui.select(choices, {
    prompt = "Choose task to run: ",
    format_item = function(item)
      return item.display
    end,
  }, function(choice)
    if choice then
      local success, err_msg = self:execute_task(choice.value, available_tasks, file_info)
      if not success then
        echo_message("Error executing task '" .. choice.value .. "': " .. err_msg, "ErrorMsg")
      end
    end
  end)
end

local manager = TaskRunner.new()

vim.api.nvim_create_user_command("Task", function(opts)
  local ok, result = pcall(function()
    local tasks, err_tasks = manager:load_tasks()

    if not tasks then
      echo_message(err_tasks or "", "ErrorMsg")
      return
    end

    local file_info = get_current_file_info()

    local available_tasks, err_filetype = manager:get_filetype_tasks(tasks, file_info)
    if not available_tasks then
      echo_message(err_filetype or "", "ErrorMsg")
      return
    end

    if opts.args and opts.args ~= "" then
      local success, err_msg = manager:execute_task(opts.args, available_tasks, file_info)
      if not success then
        echo_message(err_msg or "", "ErrorMsg")
        manager:select_and_run_task(available_tasks, file_info)
      end
    else
      manager:select_and_run_task(available_tasks, file_info)
    end
  end)

  if not ok then
    echo_message(result or "", "ErrorMsg")
  end
end, {
  nargs = "?",
  complete = function(arg_lead)
    local ok, result = pcall(function()
      local tasks, err_tasks = manager:load_tasks()
      if not tasks then
        echo_message(err_tasks or "", "ErrorMsg")
        return
      end

      local file_info = get_current_file_info()

      local available_tasks, err_filetype = manager:get_filetype_tasks(tasks, file_info)
      if not available_tasks then
        echo_message(err_filetype or "", "ErrorMsg")
        return
      end

      local completions = {}

      for task_name, _ in pairs(available_tasks) do
        if task_name:lower():find(arg_lead:lower(), 1, true) then
          table.insert(completions, task_name)
        end
      end

      return completions
    end)

    if not ok then
      return {}
    else
      return result
    end
  end,
})
