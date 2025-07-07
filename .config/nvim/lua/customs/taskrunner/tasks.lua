return {
  filetypes = {
    ft_mappings = {
      c = { "h" },
      asm = { "nasm" },
      rust = { "cargo" },
      shell = { "sh", "bash" },
    },
    c = {
      build = {
        cmd = "mkdir -p build && gcc % -o ./build/%:t:r -Wall -Werror -g",
      },
      run = {
        cmd = "./build/%:t:r",
        prelaunch = "build",
      },
    },
    cpp = {
      build = {
        cmd = "mkdir -p build && g++ % -o ./build/%:t:r -Wall -Werror -g",
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
    sh = {
      run = {
        cmd = "bash %",
      },
    },
  },

  projects = {
    pio = {
      root_markers = { "platformio.ini" },
      tasks = {
        build = { cmd = "pio run" },
        upload = { cmd = "pio run -t upload" },
        uploadfs = { cmd = "pio run -t uploadfs" },
        monitor = { cmd = "pio run -t monitor" },
        run = { cmd = "pio run -t upload -t monitor" },
        compiledb = { cmd = "pio run -t compiledb" },
        clean = { cmd = "pio run -t clean" },
        home = { cmd = "pio home --shutdown-timeout 1" },
      },
    },
    cmake = {
      root_markers = { "CMakeLists.txt" },
      tasks = {
        build = { cmd = "!CMakeBuild" },
        run = { cmd = "!CMakeRun" },
        clean = { cmd = "!CMakeClean" },
        debug = { cmd = "!CMakeDebug" },
      },
    },
    espidf = {
      priority = 10,
      root_markers = { "sdkconfig.*" },
      tasks = {
        build = { cmd = "idf.py build" },
        flash = { cmd = "idf.py -p /dev/ttyUSB0 flash" },
        monitor = { cmd = "idf.py -p /dev/ttyUSB0 monitor" },
        run = { cmd = "idf.py -p /dev/ttyUSB0 flash monitor" },
        erase = { cmd = "idf.py -p /dev/ttyUSB0 erase-flash" },
        menuconfig = { cmd = "idf.py menuconfig" },
        clean = { cmd = "idf.py fullclean" },
        reconfigure = { cmd = "idf.py reconfigure" },
      },
    },
  },
}
