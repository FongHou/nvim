vim.g.send_disable_mapping = true
vim.g.send_multiline = {
  ghci = { begin = ":{\n", ["end"] = "\n:}\n", newline = "\n" },
}

local map = vim.keymap.set
local options = { noremap = true, silent = true, desc = "Send to Repl" }

map("n", ",$", "<Plug>Send$", options)
map("n", ",;", "<Plug>SendLine", options)
map("v", ",;", "<Plug>Send", options)

vim.api.nvim_create_user_command("Repl", ":call g:send_target.send(['<args>'])", { nargs = 1 })
