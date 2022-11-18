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
    local port = 6666
    vim.g["conjure#client#clojure#nrepl#connection#auto_repl#port"] = port
    vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "bb nrepl-server localhost:" .. port
  end,
})

autocmd("BufEnter", {
  pattern = "*.cljs",
  callback = function()
    local port = 9999
    vim.g["conjure#client#clojure#nrepl#connection#auto_repl#port"] = port
    vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "nbb nrepl-server :port " .. port
  end,
})

autocmd("VimLeave", {
  callback = function()
    local port = vim.g["conjure#client#clojure#nrepl#connection#auto_repl#port"]
    local portfile = io.open(".nrepl-port", "r")
    if portfile and port == portfile:read("n") then
      vim.fn.delete(".nrepl-port")
    end
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

-- inform lspconfig about fennel-ls
local lspconfig = require("lspconfig")
require("lspconfig.configs")["fennel-ls"] = {
  default_config = {
    cmd = { "fennel-ls" },
    filetypes = { "fennel" },
    root_dir = function(dir)
      return lspconfig.util.find_git_ancestor(dir)
    end,
    settings = {},
  },
}
-- setup fennel-ls
local utils = require("config.lsp.utils")
lspconfig["fennel-ls"].setup({
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(client, bufnr)
    utils.custom_lsp_attach(client, bufnr)
  end,
})
