vim.opt_local.lisp = true

local wk = require("which-key")
wk.register({
  c = { "compile" },
}, { prefix = "<localleader>", mode = "n", silent = true })

local function options(desc)
  return { buffer = true, noremap = true, silent = true, desc = desc }
end

local map = vim.keymap.set
map("n", ",cc", "<Cmd>FnlCompileBuffer<CR>", options("Compile buffer"))
map("n", ",cl", "<Cmd>FnlPeek<CR>", options("Peek Lua output"))
map("n", ",co", "<Cmd>FnlGotoOutput<CR>", options("Goto Lua output"))
map(
  "i",
  "<C-k>",
  -- need <Left>...<Right> here to expand <cexpr> in lisp parens
  "<Left><C-o>:ConjureEval ,complete <C-r>=expand('<cexpr>')<CR><CR><Right>",
  options("Complete symbol")
)

local command = vim.api.nvim_create_user_command
command("FnlApropos", "ConjureEval ,apropos <args>", { nargs = 1 })
command("FnlComplete", "ConjureEval ,complete <args>", { nargs = 1 })
command("FnlDoc", "ConjureEval ,doc <args>", { nargs = 1 })
command("FnlFind", "ConjureEval ,find <args>", { nargs = 1 })
command("FnlReload", "ConjureEval ,reload <args>", { nargs = 1 })
