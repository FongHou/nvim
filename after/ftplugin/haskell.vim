lua <<LUA

local wk = require("which-key")
local keys = {
    g = "hoogle search",
    h = "ghci :doc",
    i = "ghci :info",
    j = "ghci :instances",
    k = "ghci :kind",
    l = "ghci :load",
    r = "ghci :reload",
    R = "ghci :main",
    t = "ghci :type",
    T = "ghci :doctest",
  }

wk.register(keys, {mode = "n", prefix = "<localleader>", silent = true})
wk.register(keys, {mode = "v", prefix = "<localleader>", silent = true})

LUA

setlocal iskeyword+=.

nnoremap <silent><nowait> <localleader>g   :Hoogle <C-r>=expand('<cword>')<CR><CR>
vnoremap <silent><nowait> <localleader>g y :Hoogle <C-r>=@"<CR><CR>

nnoremap <silent><nowait> <localleader>l :w <bar>:Repl :load! *<C-r>=expand('%:p:.')<CR><CR>
nnoremap <silent><nowait> <localleader>r :w <bar>:Repl :reload!<CR>

nnoremap <silent><nowait> <localleader>R    <bar>:Repl :main<CR>
nnoremap <silent><nowait> <localleader>T    <bar>:Repl :doctest <C-r>=expand('%:p:.')<CR><CR>

nnoremap <silent><nowait> <localleader>h   :Repl :doc <C-r>=expand('<cword>')<CR><CR>
nnoremap <silent><nowait> <localleader>i   :Repl :info <C-r>=expand('<cexpr>')<CR><CR>

nnoremap <silent><nowait> <localleader>j   :Repl :instances <C-r>=expand('<cexpr>')<CR><CR>
vnoremap <silent><nowait> <localleader>j y :Repl :instances <C-r>=@"<CR><CR>

nnoremap <silent><nowait> <localleader>k   :Repl :kind <C-r>=expand('<cexpr>')<CR><CR>
vnoremap <silent><nowait> <localleader>k y :Repl :kind! <C-r>=@"<CR><CR>

nnoremap <silent><nowait> <localleader>t   :Repl :type +d <C-r>=expand('<cexpr>')<CR><CR>
vnoremap <silent><nowait> <localleader>t   <Cmd>call GHC_type_at()<CR>

inoremap <buffer><silent><C-x><C-j>  <Left><C-o>:HaskComplete import <C-r>=expand('<cexpr>')<CR><CR><Right>
inoremap <buffer><silent><C-j>       <Left><C-o>:HaskComplete <C-r>=expand('<cexpr>')<CR><CR><Right>

command -nargs=1 -complete=tag HaskComplete Repl :complete repl 1-15 "<args>"

function! GHC_type_at()
  let file = expand('%:p:.')
  let [startln, startcol] = getpos('v')[1:2]
  let [endln, endcol] = getcursorcharpos()[1:2]
  if startln > endln
    let [startln, endln] = [endln, startln]
  endif
  if startcol > endcol
    let [startcol, endcol] = [endcol, startcol]
  endif
  :execute 'Repl :type-at ' . join([file, startln, startcol, endln, endcol], ' ')
endfunction


let g:hoogle_open_link = 'edge'
let g:hoogle_fzf_preview = 'down:40%:wrap'
let g:hoogle_fzf_window = {'window': 'call hoogle#floatwindow(40,60)'}

setlocal tags+=.haskell.tags
setlocal omnifunc=haskellcomplete#Complete

" cabal install fast-tags
command HaskTags silent !find ~/.hackage .hackage -name '*.cabal' -print0 | xargs -0 fast-tags --cabal --qualified -o .haskell.tags

" cabal install ghc-tags
augroup Haskell
  autocmd!
  au BufWritePost *.hs  silent !ghc-tags -c &
augroup END

" cabal install hasktags
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
