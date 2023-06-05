(import-macros {: augroup! : au! : command!
                : g! : go! : set!
                : map! : unmap! : <Cmd> : <C-u>}
  :nvim-laurel.macros)

(g! :maplocalleader ",")

(set! :smartcase true)
(set! :ignorecase true)

(augroup! :HLSearch
  (au! :CmdlineEnter ["/" "?"] "set hlsearch")
  (au! :CmdlineLeave ["/" "?"] "set nohlsearch"))

(augroup! :SystemClip
  [:TextYankPost "if v:event.operator ==# 'y' | call system('clip', @\") | endif"])

;; Leap
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
