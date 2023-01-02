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

map("n", ",is", ":ConjureEval (tap> (eval `(sc.api/defsc ~(sc.api/last-ep-id))))<CR>", options("sc/defsc"))
map("n", ",iu", ":ConjureEval (eval `(sc.api/undefsc ~(sc.api/last-ep-id)))<CR>", options("sc/undefsc"))
map("n", ",ix", ":ConjureEval (sc.api/dispose-all!)<CR>", options("sc/dispose-all!"))

-- prepare portal
-- scope-capture data_readers.clj {sc/letsc user/read-letsc}
--[[
(in-ns 'user)
(defn read-letsc [form]
  `(sc.api/letsc ~((requiring-resolve 'sc.api/last-ep-id)) ~form))
--]]
map(
  "n",
  ",ip",
  [[:ConjureEval (do (in-ns 'user) (add-tap (requiring-resolve 'portal.api/submit)) (def portal ((requiring-resolve 'portal.api/open))) (defn read-letsc [form] `(sc.api/letsc ~((requiring-resolve 'sc.api/last-ep-id)) ~form)) (set! *data-readers* (assoc *data-readers* 'sc/letsc #'read-letsc)))<CR>]],
  options("portal")
)

map("v", ",e", 'y :<C-u>ConjureEval #sc/letsc <C-r>=@"<CR><CR>', options("letsc form"))
-- use this in babashka
map(
  "v",
  ",E",
  [[y :<C-u>ConjureEval (binding [*data-readers* (assoc *data-readers* 'sc/letsc #'user/read-letsc)] (eval (read-string "#sc/letsc <C-r>=substitute(getreg('"'), '"', '\\"', 'g')<CR>")))<CR>]],
  options("letsc form")
)

-- flow-storm-debugger
map("v", ",t", 'y :<C-u>ConjureEval (flow-storm.api/instrument* {} <C-r>=@"<CR>)<CR>', options("trace form"))
map("v", ",r", 'y :<C-u>ConjureEval (flow-storm.api/runi {} <C-r>=@"<CR>)<CR>', options("rtrace form"))

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
