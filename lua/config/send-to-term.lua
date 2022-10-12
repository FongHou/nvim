vim.g.send_disable_mapping = true
vim.g.send_multiline = {
  ghci = { begin = ":{\n", ["end"] = "\n:}\n", newline = "\n" },
}

local map = vim.keymap.set
local default_options = { noremap = true, silent = true, desc = "ipython" }

vim.api.nvim_create_user_command("Repl", ":call g:send_target.send(['<args>'])", { nargs = 1 })

map("n", ",,", "<Plug>SendLine", default_options)
map("v", ",,", "<Plug>Send", default_options)
map("n", ",%i", ":Repl %pinfo <C-r>=expand('<cexpr>')<CR><CR>", default_options)
map("v", ",%i", 'y :Repl %pinfo <C-r>=@"<CR><CR>', default_options)
map("n", ",%r", ":Repl %run -e -i <C-r>=expand('%:p')<CR><CR>", default_options)
map("n", ",%t", ":Repl !pytest -v --doctest-modules <C-r>=expand('%:p')<CR><CR>", default_options)
map(
  "n",
  ",%d",
  ":Repl !pytest --trace --pdb --pdbcls=IPython.terminal.debugger:TerminalPdb <C-r>=expand('%:p')<CR>::<C-r>=expand('<cword>')<CR><CR>",
  default_options
)
vim.api.nvim_create_user_command("Repl", ":call g:send_target.send(['<args>'])", { nargs = 1 })

local options = { noremap = true, silent = true, desc = "Send to Repl" }

map("n", ",,", "<Plug>SendLine", options)
map("v", ",,", "<Plug>Send", options)
