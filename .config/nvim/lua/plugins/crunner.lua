return {
  "CRAG666/code_runner.nvim",
  cmd = "RunCode",
  opts = {
    mode = "float",
    startinsert = true,
    term = {
      size = 10,
    },
    float = {
      border = "single",
    },
    filetype = {
      python = "python -u $fileName",
      c = {
        "cd $dir",
        "&& gcc $fileName -o /tmp/$fileNameWithoutExt -Wall -lm",
        "&& /tmp/$fileNameWithoutExt",
        "&& rm /tmp/$fileNameWithoutExt",
      },
      cpp = {
        "cd $dir",
        "&& g++ $fileName -o /tmp/$fileNameWithoutExt -Wall",
        "&& /tmp/$fileNameWithoutExt",
        "&& rm /tmp/$fileNameWithoutExt",
      },
    },
  },
}
