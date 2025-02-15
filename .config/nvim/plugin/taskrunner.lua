if vim.g.loaded_tasks_plugin then
  return
end
vim.g.loaded_tasks_plugin = true

local TASKS_FILE = "tasks.lua"

local FILENAME_PATTERNS = {
  FULL = "${fileName}",
  NO_EXT = "${fileNameNoExt}",
}

local FILETYPE_MAP = {
  py = "python",
}

local function check_file_exists(filename)
  return vim.uv.fs_stat(filename) ~= nil
end

local function echo_message(msg, highlight, history)
  vim.api.nvim_echo({ { "[Tasks] " .. msg, highlight or "None" } }, history or true, {})
end

local function get_current_file_info()
  local full_path = vim.fn.expand("%:p:.")
  return {
    full_path = full_path,
    extension = vim.fn.fnamemodify(full_path, ":e"),
    no_ext = vim.fn.fnamemodify(full_path, ":r"),
  }
end

local TaskRunner = {}

function TaskRunner.new()
  local self = setmetatable({}, { __index = TaskRunner })
  return self
end

function TaskRunner:load_tasks()
  if not check_file_exists(TASKS_FILE) then
    error("tasks.lua doesn't exist", 0)
  end

  package.loaded.tasks = nil
  return require("tasks")
end

function TaskRunner:get_filetype_tasks(tasks, file_info)
  local filetype = FILETYPE_MAP[file_info.extension] or file_info.extension
  local filetype_tasks = tasks[filetype]
  local all_tasks = tasks["all"]

  if not filetype_tasks and not all_tasks then
    error("Can't find any tasks for current file", 0)
  end

  if type(filetype_tasks) == "string" then
    filetype_tasks = { [file_info.extension] = filetype_tasks }
  end

  if type(all_tasks) == "string" then
    all_tasks = { all = all_tasks }
  end

  return vim.tbl_deep_extend("keep", filetype_tasks or {}, all_tasks or {})
end

function TaskRunner:prepare_command(command, file_info)
  return command:gsub(FILENAME_PATTERNS.FULL, file_info.full_path):gsub(FILENAME_PATTERNS.NO_EXT, file_info.no_ext)
end

function TaskRunner:execute_task(task_name, available_tasks, file_info, is_prelaunch)
  local task = available_tasks[task_name]
  if not task then
    return false
  end

  local should_run = true
  if task.prelaunch then
    if not self:execute_task(task.prelaunch, available_tasks, file_info, true) then
      should_run = false
    end
  end

  local command = type(task) == "table" and task.cmd or task
  command = command .. " " .. (task.args or "")
  command = self:prepare_command(command, file_info)

  if is_prelaunch then
    local output = vim.fn.system(command)

    if vim.v.shell_error ~= 0 then
      echo_message(output, "ErrorMsg")
      return false
    end

    if output ~= "" then
      echo_message(output)
    end
  elseif should_run then
    vim.cmd("split | term " .. command)
    vim.cmd("startinsert")
  end

  return true
end

function TaskRunner:select_and_run_task(available_tasks, file_info)
  local choices = vim.tbl_keys(available_tasks)
  vim.ui.select(choices, { prompt = "Choose task to run: " }, function(choice)
    if choice then
      self:execute_task(choice, available_tasks, file_info)
    end
  end)
end

local manager = TaskRunner.new()

vim.api.nvim_create_user_command("Task", function(opts)
  local ok, result = pcall(function()
    local tasks = manager:load_tasks()
    local file_info = get_current_file_info()
    local available_tasks = manager:get_filetype_tasks(tasks, file_info)

    if opts.args and opts.args ~= "" then
      if not manager:execute_task(opts.args, available_tasks, file_info) then
        echo_message("Invalid task name: " .. opts.args, "WarningMsg", false)
        manager:select_and_run_task(available_tasks, file_info)
      end
    else
      manager:select_and_run_task(available_tasks, file_info)
    end
  end)

  if not ok then
    echo_message(result, "ErrorMsg")
  end
end, {
  nargs = "?",
  complete = function(arg_lead)
    local tasks = manager:load_tasks()
    local file_info = get_current_file_info()
    local available_tasks = manager:get_filetype_tasks(tasks, file_info)

    local completions = {}

    for task_name, _ in pairs(available_tasks) do
      if task_name:lower():find(arg_lead:lower(), 1, true) then
        table.insert(completions, task_name)
      end
    end

    return completions
  end,
})

vim.keymap.set("n", "<c-b>", "<cmd>Task run<cr>")
vim.keymap.set("n", "<leader>cb", "<cmd>Task build<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Task<cr>")
