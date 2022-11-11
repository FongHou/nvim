(import-macros {: g! : set! : map! : augroup! : command!} :hibiscus.vim)

;; autocmd
(augroup! :SystemClip
  [[TextYankPost] *
   "if v:event.operator ==# 'y' | call system('clip.exe', @\") | endif"])

(augroup! :HLSearch
  [[CmdlineEnter] ["/" "?"] "set hlsearch"]
  [[CmdlineLeave] ["/" "?"] "set nohlsearch"])

;; keymaps
(g! maplocalleader ",")

(local leap (require :leap))
(map! [nox] "ss" #(leap.leap {:target_windows [(vim.fn.win_getid)]})
      "Jump to char2")
(map! [nox] "gs" #(leap.leap {:target_windows
                              (vim.tbl_filter
                                #(. (vim.api.nvim_win_get_config $) :focusable)
                                (vim.api.nvim_tabpage_list_wins 0))})
      "Jump to char2 cross windows")
(map! [nox] "st" (. (require :leap-ast) :leap)
      "Jump to treesitter")

;; send-to-term
(g! send_disable_mapping true)
(g! send_multiline {:ghci {:begin ":{\n" :end "\n:}\n" :newline "\n"}})

(map! [n :silent] ",$" "<Plug>Send$" "Send to Repl")
(map! [n :silent] ",;" "<Plug>SendLine" "Send to Repl")
(map! [v :silent] ",;" "<Plug>Send" "Send to Repl")

(command! [:nargs 1] "Repl" ":call g:send_target.send(['<args>'])")

;; tmux-navigator
(g! tmux_navigator_no_wrap true)
(g! tmux_navigator_disable_when_zoomed true)
(g! tmux_navigator_preserve_zoom true)
