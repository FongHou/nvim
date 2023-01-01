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

-- portal
map(
  "n",
  ",ip",
  [[:ConjureEval (do (in-ns 'user) (add-tap (requiring-resolve 'portal.api/submit)) (def portal ((requiring-resolve 'portal.api/open))))<CR>]],
  options("portal")
)

-- flow-storm-debugger
map("v", ",t", 'y :ConjureEval #trace <C-r>=@"<CR><CR>', options("trace form"))
map("v", ",r", 'y :ConjureEval #rtrace <C-r>=@"<CR><CR>', options("rtrace form"))

-- scope-capture
map("n", ",iv", ":ConjureEval (eval `(sc.api/defsc ~(sc.api/last-ep-id)))<CR>", options("sc/defsc"))
map("n", ",iu", ":ConjureEval (eval `(sc.api/undefsc ~(sc.api/last-ep-id)))<CR>", options("sc/undefsc"))
map("n", ",ix", ":ConjureEval (sc.api/dispose-all!)<CR>", options("sc/dispose-all!"))
-- data_readers.clj: {sc/letsc user/read-letsc}
--[[
(in-ns 'user)
(defn read-letsc [form]
  `(sc.api/letsc ~((requiring-resolve 'sc.api/last-ep-id)) ~form))
--]]
map("v", ",e", 'y :ConjureEval #sc/letsc <C-r>=@"<CR><CR>', options("letsc form"))

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
