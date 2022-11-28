vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = 0
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
vim.g["conjure#mapping#eval_motion"] = ","
vim.g["conjure#mapping#eval_visual"] = ","
vim.g["conjure#mapping#doc_word"] = "vd"

local autocmd = vim.api.nvim_create_autocmd

local wk = require("which-key")
autocmd("FileType", {
  pattern = { "clojure", "fennel", "lua", "python" },
  callback = function()
    wk.register({
      c = { "connect" },
      e = { "eval" },
      g = { "goto" },
      l = { "log" },
      r = { "run" },
      t = { "test" },
      v = { "view" },
    }, { prefix = "<localleader>", mode = "n", silent = true })
  end,
})

autocmd("BufEnter", {
  pattern = "*.clj",
  callback = function()
    vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "bb nrepl-server localhost:$port"
  end,
})

autocmd("BufEnter", {
  pattern = "*.cljs",
  callback = function()
    vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "nbb nrepl-server :port $port"
  end,
})

local baleia = require("baleia").setup({ line_starts_at = 3 })
autocmd("BufWinEnter", {
  pattern = { "conjure-log-*" },
  callback = function()
    vim.diagnostic.disable(0)
    baleia.automatically(vim.api.nvim_get_current_buf())
  end,
})
