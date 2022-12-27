(import-macros {: command! : augroup! : augroup+ : au!}
  :nvim-laurel.macros)

(command! [:nargs 1] "Repl" ":call g:send_target.send(['<args>'])")

(augroup! :SystemClip
  [:TextYankPost "if v:event.operator ==# 'y' | call system('clip.exe', @\") | endif"])

(augroup! :HLSearch
  (au! :CmdlineEnter ["/" "?"] "set hlsearch")
  (au! :CmdlineLeave ["/" "?"] "set nohlsearch"))
