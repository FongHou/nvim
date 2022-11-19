(import-macros {: g! : set!
                : augroup! : au! : command!
                : nmap! : vmap! : map!} :nvim-laurel.macros)

(set! :cmdheight 0)

;; autocmd
(augroup! :SystemClip
  [:TextYankPost "if v:event.operator ==# 'y' | call system('clip.exe', @\") | endif"])

(augroup! :HLSearch
  (au! :CmdlineEnter ["/" "?"] "set hlsearch")
  (au! :CmdlineLeave ["/" "?"] "set nohlsearch"))

(local parinfer (require :parinfer))
(augroup! :SetupParinfer
  [:FileType [:fennel :clojure]
   (fn []
     (parinfer.setup! {:trail_highlight false})
     (parinfer.attach-current-buf!))])

;; keymaps
(g! :maplocalleader ",")

(local leap (require :leap))
(map! [:n :o :x] [:silent :desc "Jump to char2"]
      "ss" #(leap.leap {:target_windows [(vim.fn.win_getid)]}))

(map! [:n :o :x] [:silent :desc "Jump to char2 (window)"]
      "gs" #(leap.leap {:target_windows
                        (vim.tbl_filter
                          #(. (vim.api.nvim_win_get_config $) :focusable)
                          (vim.api.nvim_tabpage_list_wins 0))}))

(map! [:n :o :x] [:silent :desc "Jump to TS object"]
      "st" (partial (. (require :leap-ast) :leap)))

;; send-to-term
(g! :send_disable_mapping true)
(g! :send_multiline {:ghci {:begin ":{\n" :end "\n:}\n" :newline "\n"}})

(nmap! [:silent :desc "Send to repl"] ",$" "<Plug>Send$")
(nmap! [:silent :desc "Send to repl"] ",;" "<Plug>SendLine")
(vmap! [:silent :desc "Send to repl"] ",;" "<Plug>Send")

(command! [:nargs 1] "Repl" ":call g:send_target.send(['<args>'])")

;; tmux-navigator
(g! :tmux_navigator_no_wrap true)
(g! :tmux_navigator_disable_when_zoomed true)
(g! :tmux_navigator_preserve_zoom true)
