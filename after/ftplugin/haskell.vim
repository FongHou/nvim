nnoremap <silent><nowait> <localleader>g   :Hoogle <C-r>=expand('<cword>')<CR><CR>
vnoremap <silent><nowait> <localleader>g y :Hoogle <C-r>=@"<CR><CR>

nnoremap <silent><nowait> <localleader>h   :Repl :hdoc <C-r>=expand('<cexpr>')<CR><CR>
nnoremap <silent><nowait> <localleader>i   :Repl :info <C-r>=expand('<cexpr>')<CR><CR>
vnoremap <silent><nowait> <localleader>i y :Repl :info <C-r>=@"<CR><CR>

nnoremap <silent><nowait> <localleader>j   :Repl :instances <C-r>=expand('<cexpr>')<CR><CR>
vnoremap <silent><nowait> <localleader>j y :Repl :instances <C-r>=@"<CR><CR>

nnoremap <silent><nowait> <localleader>k   :Repl :kind <C-r>=expand('<cexpr>')<CR><CR>
vnoremap <silent><nowait> <localleader>k y :Repl :kind! <C-r>=@"<CR><CR>

nnoremap <silent><nowait> <localleader>l   :Repl :load! *<C-r>=expand('%:p')<CR><CR>
nnoremap <silent><nowait> <localleader>r   :Repl :reload!<CR>

lua <<WKMAP

local wk = require("which-key")
local keys = {
    g = "hoogle search",
    h = "ghci hdoc",
    i = "ghci info",
    j = "ghci instances",
    k = "ghci kind",
    l = "ghci load",
    r = "ghci reload",
  }

wk.register(keys, {mode = "n", prefix = "<localleader>", silent = true})
wk.register(keys, {mode = "v", prefix = "<localleader>", silent = true})

WKMAP

command! -nargs=0 Hlint :call <SID>ApplyHlint()
function! s:ApplyHlint()
  let l = line(".")
  let c = col(".")
  let l:filter = "%! hlint - --refactor  --refactor-options=\"--pos ".l.','.c."\""
  execute l:filter
  silent if v:shell_error == 1| undo | endif
  call cursor(l, c)
endfunction

setlocal tags+=../tags;,~/.hackage/*/tags
augroup Haskell
  autocmd!
  au BufWritePost *.hs  silent !ghc-tags -c
augroup END

let g:hoogle_open_link = 'edge'
let g:hoogle_fzf_preview = 'down:40%:wrap'
let g:hoogle_fzf_window = {'window': 'call hoogle#floatwindow(40,60)'}

let g:tagbar_width = max([40, winwidth(0) / 4])
let g:tagbar_type_haskell = {
    \ 'ctagsbin'    : 'hasktags',
    \ 'ctagsargs'   : '-x -c -o-',
    \ 'kinds'       : [
        \  'm:modules:0:1',
        \  'd:data:0:1',
        \  'd_gadt:data gadt:0:1',
        \  'nt:newtype:0:1',
        \  'c:classes:0:1',
        \  'i:instances:0:1',
        \  'cons:constructors:0:1',
        \  'c_gadt:constructor gadt:0:1',
        \  'c_a:constructor accessors:1:1',
        \  't:type names:0:1',
        \  'pt:pattern types:0:1',
        \  'pi:pattern implementations:0:1',
        \  'ft:function types:0:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'          : '.',
    \ 'kind2scope'   : {
        \ 'm'        : 'module',
        \ 'd'        : 'data',
        \ 'd_gadt'   : 'd_gadt',
        \ 'c_gadt'   : 'c_gadt',
        \ 'nt'       : 'newtype',
        \ 'cons'     : 'cons',
        \ 'c_a'      : 'accessor',
        \ 'c'        : 'class',
        \ 'i'        : 'instance'
    \ },
    \ 'scope2kind'   : {
        \ 'module'   : 'm',
        \ 'data'     : 'd',
        \ 'newtype'  : 'nt',
        \ 'cons'     : 'c_a',
        \ 'd_gadt'   : 'c_gadt',
        \ 'class'    : 'ft',
        \ 'instance' : 'ft'
    \ }
\ }
