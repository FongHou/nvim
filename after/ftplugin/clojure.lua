local wk = require("which-key")
wk.register({
  p = { "portal" },
  r = { "refresh" },
  s = { "session" },
}, { prefix = "<localleader>", mode = "n", silent = true })

local function options(desc)
  return { buffer = true, noremap = true, silent = true, desc = desc }
end

local map = vim.keymap.set
map("n", ",p1", ":ConjureEval (tap> *1)<CR>", options("tap last result"))
map("n", ",pe", ":ConjureEval (tap> (Throwable->map *e))<CR>", options("tap last exception"))
map("n", ",pn", ":ConjureEval (tap> (-> *ns* (clojure.datafy/datafy) :publics))<CR>", options("tap current namespace"))
map("n", ",ps", ":ConjureEval (tap> (eval `(sc.api/defsc ~(sc.api/last-ep-id))))<CR>", options("tap scope-capture"))
map("n", ",pc", ":ConjureEval (portal.api/clear)<CR>", options("portal clear"))
map("n", ",po", ":ConjureEval (portal.api/open)<CR>", options("portal open"))
map("v", ",d", 'y :ConjureEval (tap> (def <C-r>=@"<CR>))<CR>', options("tap def binding"))
map("v", ",p", 'y :ConjureEval (tap> <C-r>=@"<CR>)<CR>', options("tap selected form"))
map("v", ",i", 'y :ConjureEval #reveal/inspect <C-r>=@"<CR><CR>', options("inspect selected form"))
map("v", ",r", 'y :ConjureEval #rtrace <C-r>=@"<CR><CR>', options("trace selected form"))

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
