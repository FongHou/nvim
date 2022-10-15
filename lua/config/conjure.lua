vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "nbb nrepl-server :port 8794"
vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
vim.g["conjure#client#fennel#stdio#command"] = "fennel --lua luajit"
vim.g["conjure#mapping#eval_motion"] = ","
vim.g["conjure#mapping#eval_visual"] = ","
vim.g["conjure#mapping#doc_word"] = "vd"

local wk = require("which-key")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "clojure", "fennel", "lua", "python" },
  callback = function()
    wk.register({
      c = { "connect" },
      e = { "eval" },
      g = { "goto" },
      l = { "log" },
      r = { "repl" },
      s = { "session" },
      t = { "test" },
      v = { "view" },
    }, { prefix = "<localleader>", mode = "n", silent = true })
  end,
})
