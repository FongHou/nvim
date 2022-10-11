vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "nbb nrepl-server :port 8794"
vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
vim.g["conjure#client#clojure#nrepl#eval#raw_out"] = true
vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
vim.g["conjure#client#fennel#stdio#command"] = "fennel --lua luajit"

local wk = require("which-key")
local default_options = { silent = true }
wk.register({
  c = { "connect" },
  e = { "eval" },
  g = { "goto" },
  l = { "log" },
  r = { "refresh" },
  s = { "session" },
  t = { "test" },
  v = { "view" },
  f = { name = "refactor" },
}, { prefix = "<localleader>", mode = "n", default_options })
