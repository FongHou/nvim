vim.g.send_disable_mapping = true
vim.g.send_multiline = {
  ghci = { begin = ":{\n", ["end"] = "\n:}\n", newline = "\n" },
}

vim.api.nvim_create_user_command("Repl", ":call g:send_target.send(['<args>'])", { nargs = 1 })

local options = { noremap = true, silent = true, desc = "Send to Repl" }

local map = vim.keymap.set
map("n", ",,", "<Plug>SendLine", options)
map("v", ",,", "<Plug>Send", options)
