local wk = require("which-key")
wk.register({
  [">"] = { "tap>" },
}, { prefix = "<localleader>", mode = "n", silent = true })

local function options(desc)
  return { buffer = true, noremap = true, silent = true, desc = desc }
end

local map = vim.keymap.set
map("n", ",>1", ":ConjureEval (tap> *1)<CR>", options(" *1"))
map("n", ",>2", ":ConjureEval (tap> *2)<CR>", options(" *2"))
map("n", ",>3", ":ConjureEval (tap> *3)<CR>", options(" *3"))
map("n", ",>e", ":ConjureEval (tap> *e)<CR>", options(" *e"))
map("v", ",>", 'y :ConjureEval (tap> <C-r>=@"<CR>)<CR>', options("tap> visual select"))
map("n", ",cb", ":ConjureEval (nextjournal.clerk/show! \"<C-r>=expand('%')<CR>\")<CR>", options("Show clerk notebook"))
