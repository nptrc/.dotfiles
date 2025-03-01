return {
  {
    "Civitasv/cmake-tools.nvim",
    config = function()
      require("cmake-tools").setup({
        cmake_build_directory = "build",
        cmake_soft_link_compile_commands = false,
        cmake_generate_options = { "-GNinja", "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      })
    end,
  },
}
