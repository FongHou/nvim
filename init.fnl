(import-macros {: augroup! : augroup+ : au! : command!
                : g! : map! : unmap! : <Cmd> : <C-u>}
  :nvim-laurel.macros)

(augroup! :SystemClip
  [:TextYankPost "if v:event.operator ==# 'y' | call system('clip.exe', @\") | endif"])

(augroup! :HLSearch
  (au! :CmdlineEnter ["/" "?"] "set hlsearch")
  (au! :CmdlineLeave ["/" "?"] "set nohlsearch"))

(g! :maplocalleader ",")

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

;; Telescope
(map! :n [:silent :desc "Telescope recent items"]
      "<leader><space>" "<cmd>Telescope resume<cr>")
(map! :n [:silent :desc "Telescope tags"]
      "g]" "<cmd>Telescope tags<cr>")
(map! :n [:silent :desc "Toggle Tagbar"]
      "g[" "<cmd>TagbarToggle<cr>")

;; send-to-term
(command! [:nargs 1] "Repl" ":call g:send_target.send(['<args>'])")

(map! :n [:silent :desc "Send line to repl"] ",$" "<Plug>Send$")
(map! :n [:silent :desc "Send line to repl"] ",;" "<Plug>SendLine")
(map! :v [:silent :desc "Send selected to repl"] ",;" "<Plug>Send")
