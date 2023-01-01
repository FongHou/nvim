local wk = require("which-key")
wk.register({
  i = { "inspect" },
  r = { "refresh" },
  s = { "session" },
}, { prefix = "<localleader>", mode = "n", silent = true })

local function options(desc)
  return { buffer = true, noremap = true, silent = true, desc = desc }
end

local map = vim.keymap.set
map("n", ",i1", ":ConjureEval (tap> *1)<CR>", options("tap *1"))
map("n", ",ie", ":ConjureEval (tap> (Throwable->map *e))<CR>", options("tap *e"))
map("n", ",in", ":ConjureEval (tap> (-> *ns* (clojure.datafy/datafy) :publics))<CR>", options("tap *ns*"))
map("n", ",ic", ":ConjureEval (tap> (eval `(sc.api/defsc ~(sc.api/last-ep-id))))<CR>", options("sc/defcs"))
map("n", ",iu", ":ConjureEval (eval `(sc.api/undefsc ~(sc.api/last-ep-id)))<CR>", options("sc/undefsc"))
map("n", ",id", ":ConjureEval (sc.api/dispose-all!)<CR>", options("sc/dispose-all!"))
map("v", ",r", 'y :ConjureEval #reveal/inspect <C-r>=@"<CR><CR>', options("Reveal selected form"))
map("v", ",t", 'y :ConjureEval #rtrace <C-r>=@"<CR><CR>', options("Trace selected form"))
map(
  "n",
  ",ip",
  ":ConjureEval (do (in-ns 'user) (def portal ((requiring-resolve 'portal.api/open))) (add-tap (requiring-resolve 'portal.api/submit)))<CR>",
  options("portal")
)

local autocmd = vim.api.nvim_create_autocmd
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

local autopairs = require("nvim-autopairs")
autopairs.remove_rule("'")
autopairs.remove_rule("`")
