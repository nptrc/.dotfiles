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
local function check_file_exists(filename)
  return vim.uv.fs_stat(filename) ~= nil
end

---Echo a message to the user
---@param msg string The message to display
---@param highlight? string The highlight group to use
---@param history? boolean Whether to add the message to the command history
local function echo_message(msg, highlight, history)
  vim.api.nvim_echo({ { "[Tasks] " .. msg, highlight or "None" } }, history or true, {})
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

---Create a new TaskRunner instance
---@return TaskRunner
function TaskRunner.new()
  local self = setmetatable({}, { __index = TaskRunner })
  return self
end

---Load tasks from tasks.lua
---@return table?, string?
function TaskRunner:load_tasks()
  if not check_file_exists(TASKS_FILE) then
    return nil, "tasks.lua doesn't exist"
  end

  package.loaded.tasks = nil
  local ok, tasks = pcall(require, "tasks")
  if not ok then
    return nil, "Error loading tasks.lua:\n" .. tasks
  end
  return tasks
end

---Get tasks for the current filetype
---@param tasks table The tasks table
---@param file_info table The file information
---@return table?, string?
function TaskRunner:get_filetype_tasks(tasks, file_info)
  local filetype_mappings_from_tasks = tasks.filetype_mappings or {}
  local merged_filetype_map = vim.tbl_deep_extend("force", {}, FILETYPE_MAP, filetype_mappings_from_tasks)

  local filetype = merged_filetype_map[file_info.extension] or file_info.extension
  local filetype_tasks = tasks[filetype]
  local all_tasks = tasks["all"]

  if not filetype_tasks and not all_tasks then
    return nil, "Can't find any tasks for current file"
  end

  if type(filetype_tasks) == "string" then
    filetype_tasks = { [file_info.extension] = filetype_tasks }
  end

  if type(all_tasks) == "string" then
    all_tasks = { all = all_tasks }
  end

  return vim.tbl_deep_extend("keep", filetype_tasks or {}, all_tasks or {})
end

---Prepare a command by replacing filename placeholders
---@param command string The command to prepare
---@param file_info table The file information
---@return string
function TaskRunner:prepare_command(command, file_info)
  local prepared_command =
    command:gsub(FILENAME_PATTERNS.FULL, file_info.full_path):gsub(FILENAME_PATTERNS.NO_EXT, file_info.no_ext)
  return prepared_command
end

---Get the command to run for a task
---@param task table|string The task to get the command for
---@param file_info table The file information
---@return string
function TaskRunner:get_task_command(task, file_info)
  local command = type(task) == "table" and task.cmd or task
  local args = type(task) == "table" and task.args or ""
  command = command .. (#args > 0 and " " .. args or "")
  command = self:prepare_command(command, file_info)
  return command
end

---Execute a task
---@param task_name string The name of the task to execute
---@param available_tasks table The available tasks
---@param file_info table The file information
---@param is_prelaunch? boolean Whether this is a prelaunch task
---@return boolean, string?
function TaskRunner:execute_task(task_name, available_tasks, file_info, is_prelaunch)
  local task = available_tasks[task_name]
  if not task then
    return false, "Task '" .. task_name .. "' not found"
  end

  local should_run = true
  if task.prelaunch then
    local prelaunch_ok, prelaunch_msg = self:execute_task(task.prelaunch, available_tasks, file_info, true)
    if not prelaunch_ok then
      echo_message("Prelaunch task '" .. task.prelaunch .. "' error messages:\n" .. prelaunch_msg, "ErrorMsg")
      should_run = false
    end
  end

  local command = self:get_task_command(task, file_info)

  if is_prelaunch then
    local output = vim.fn.system(command)

    if vim.v.shell_error ~= 0 then
      echo_message("Prelaunch task '" .. task_name .. "' command failed: " .. command .. "\n", "ErrorMsg")
      return false, output
    end

    if output ~= "" then
      echo_message("Prelaunch task '" .. task_name .. "' output:\n" .. output)
    end
  elseif should_run then
    vim.cmd("split | term " .. command)
    vim.cmd("startinsert")
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
