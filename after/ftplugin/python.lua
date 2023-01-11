local vo = vim.opt_local
vo.tabstop = 4
vo.shiftwidth = 4
vo.softtabstop = 4

require("core.plugins.dap.dap").setup()

local function options(desc)
  return { buffer = true, noremap = true, silent = true, desc = desc }
end

local map = vim.keymap.set
map("n", ",i", ":Repl %pinfo <C-r>=expand('<cexpr>')<CR><CR>", options("ipython %info"))
map("v", ",i", 'y :Repl %pinfo <C-r>=@"<CR><CR>', options("ipython %info"))
map("n", ",r", ":Repl %run -e -i <C-r>=expand('%:p')<CR><CR>", options("ipython %run"))
map("n", ",t", ":Repl !pytest -v --doctest-modules <C-r>=expand('%:p')<CR><CR>", options("pytest current file"))
map(
  "n",
  ",d",
  ":Repl !pytest --trace --pdb --pdbcls=IPython.terminal.debugger:TerminalPdb <C-r>=expand('%:p')<CR>::<C-r>=expand('<cword>')<CR><CR>",
  options("pytest debug test")
)
