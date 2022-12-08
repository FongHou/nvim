local wk = require("which-key")
wk.register({
  c = { "compile" },
}, { prefix = "<localleader>", mode = "n", silent = true })

local function options(desc)
  return { buffer = true, noremap = true, silent = true, desc = desc }
end

local map = vim.keymap.set
map("n", ",cc", "<Cmd>FnlCompileBuffer<CR>", options("Compile buffer"))
map("n", ",co", "<Cmd>FnlGotoOutput<CR>", options("Output buffer"))
