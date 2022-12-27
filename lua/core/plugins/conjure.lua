local M = {
  "Olical/conjure",
  ft = { "clojure", "fennel", "lua", "python" }
  dependencies = {
    { "eraserhd/parinfer-rust", build = "cargo build --release" },
    "harrygallagher4/nvim-parinfer-rust",
    "PaterJason/cmp-conjure",
    "tpope/vim-repeat",
    "m00qek/baleia.nvim",
  },
}

function M.init()
  vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = 0
  vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
  vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
  vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
  vim.g["conjure#mapping#eval_motion"] = ","
  vim.g["conjure#mapping#eval_visual"] = ","
  vim.g["conjure#mapping#doc_word"] = "vd"

  local wk = require("which-key")
  wk.register({
    c = { "connect" },
    e = { "eval" },
    g = { "goto" },
    l = { "log" },
    r = { "run" },
    t = { "test" },
    v = { "view" },
  }, { prefix = "<localleader>", mode = "n", silent = true })
end

function M.config()
  vim.api.nvim_create_autocmd( {"BufEnter", "BufWinEnter"},
    { pattern = {"*.clj*", "*.fnl"}
      callback = function()
        local mod = require("parinfer")
        mod.setup{trail_highlight = false}
        mod.attach_current_buf()
      end}
  )
end

return M
