local wk = require("which-key")
wk.register({
  [">"] = { "tap>" },
  c = { "connect" },
  r = { "refresh" },
  s = { "session" },
  v = { "view" },
}, { prefix = "<localleader>", mode = "n", silent = true })

local function options(desc)
  return { buffer = true, noremap = true, silent = true, desc = desc }
end

local map = vim.keymap.set
map("n", ",>1", ":ConjureEval (tap> *1)<CR>", options(" *1"))
map("n", ",>2", ":ConjureEval (tap> *2)<CR>", options(" *2"))
map("n", ",>3", ":ConjureEval (tap> *3)<CR>", options(" *3"))
map("n", ",>e", ":ConjureEval (tap> *e)<CR>", options(" *e"))
map("v", ",>", 'y :ConjureEval (tap> <C-r>=@"<CR>)<CR>', options("tap selected form"))
map("v", ",i", 'y :ConjureEval #reveal/inspect <C-r>=@"<CR><CR>', options("inspect selected form"))
map("v", ",r", 'y :ConjureEval #rtrace <C-r>=@"<CR><CR>', options("trace selected form"))

map("n", ",tt", ":ConjureEval (typed.clojure/check-ns-clj)<CR>", options("type check current NS"))
map("v", ",t", 'y :ConjureEval (typed.clojure/cf <C-r>=@"<CR>)<CR>', options("type check selected form"))

local command = vim.api.nvim_create_user_command

command("Clerk", 'ConjureEval (nextjournal.clerk/show! "' .. vim.fn.expand("%") .. '")', {})

command(
  "RevealToggle",
  "ConjureEval (vlaaad.reveal/submit-command! :always-on-top (vlaaad.reveal/toggle-minimized))<CR>",
  {}
)
