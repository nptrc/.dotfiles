local default_tasks = {
  filetypes = {
    ft_mappings = {
      c = { "h" },
      cpp = { "hpp" },
      shell = { "sh", "bash" },
    },
    c = {
      build = {
        cmd = "mkdir -p build && gcc % -o ./build/%:t:r -g",
      },
      run = {
        cmd = "./build/%:t:r",
        prelaunch = "build",
      },
    },
    cpp = {
      build = {
        cmd = "mkdir -p build && g++ % -o ./build/%:t:r -g",
      },
      run = {
        cmd = "./build/%:t:r",
        prelaunch = "build",
      },
    },
    python = {
      run = {
        cmd = "python3 %",
      },
    },
    shell = {
      run = {
        cmd = "bash %",
      },
    },
  },

  projects = {
    cmake = {
      root_markers = { "CMakeLists.txt" },
      tasks = {
        build = { cmd = "!CMakeBuild" },
        run = { cmd = "!CMakeRun" },
        generate = { cmd = "!CMakeGenerate" },
        clean = { cmd = "rm -rf build compile_commands.json" },
      },
    },
    espidf = {
      priority = 10,
      root_markers = { "sdkconfig.*" },
      tasks = {
        build = { cmd = "idf.py build && ln -sf ./build/compile_commands.json ." },
        flash = { cmd = "idf.py -p /dev/tty<PORT> flash" },
        monitor = { cmd = "idf.py -p /dev/tty<PORT> monitor" },
        run = { cmd = "idf.py -p /dev/tty<PORT> flash monitor" },
        erase = { cmd = "idf.py -p /dev/tty<PORT> erase-flash" },
        menuconfig = { cmd = "idf.py menuconfig" },
        clean = { cmd = "idf.py fullclean" },
        reconfigure = { cmd = "idf.py reconfigure" },
      },
    },
    pio = {
      priority = 20,
      root_markers = { "platformio.ini" },
      tasks = {
        build = { cmd = "pio run" },
        upload = { cmd = "pio run -t upload" },
        uploadfs = { cmd = "pio run -t uploadfs" },
        monitor = { cmd = "pio run -t monitor" },
        run = { cmd = "pio run -t upload -t monitor" },
        compiledb = { cmd = "pio project init --ide vim && pio run -t compiledb" },
        clean = { cmd = "pio run -t clean" },
        home = { cmd = "pio home --shutdown-timeout 1" },
      },
    },
  },
}

for _, task_info in pairs(default_tasks.projects.espidf.tasks) do
  if string.find(task_info.cmd, "tty<PORT>") then
    task_info.prehook = function(self)
      vim.ui.input({
        prompt = "Port: ",
        default = _G.espidf_port or "USB0",
      }, function(input)
        _G.espidf_port = input
        self.cmd = string.gsub(self.cmd, "tty<PORT>", "tty" .. input)
      end)
    end
  end
end

return default_tasks
