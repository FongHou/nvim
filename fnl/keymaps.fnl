(import-macros {: map! : unmap! : <Cmd> : <C-u>}
               :nvim-laurel.macros)

(local leap (require :leap))
(map! [:n :o :x] [:silent :desc "Jump to char2"]
      "ss" #(leap.leap {:target_windows [(vim.fn.win_getid)]}))

(map! [:n :o :x] [:silent :desc "Jump to char2 in all windows"]
      "gs" #(leap.leap {:target_windows
                        (vim.tbl_filter
                          #(. (vim.api.nvim_win_get_config $) :focusable)
                          (vim.api.nvim_tabpage_list_wins 0))}))

(map! [:n :o :x] [:silent :desc "Jump to TS object"]
      "st" (partial (. (require :leap-ast) :leap)))

;; send-to-term
(map! :n [:silent :desc "Send line to repl"] ",$" "<Plug>Send$")
(map! :n [:silent :desc "Send line to repl"] ",;" "<Plug>SendLine")
(map! :v [:silent :desc "Send selected to repl"] ",;" "<Plug>Send")
