syn on
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set lbr
set hlsearch
set wildmenu " nicer tab-completion for Vim commands
set belloff=all  " never beep

map <Esc>[B <Down>
map <Esc>[A <Up>
map <Esc>[D <Left>
map <Esc>[C <Right>
imap <Esc>[B <Down>
imap <Esc>[A <Up>
imap <Esc>[D <Left>
imap <Esc>[C <Right>


if &term =~ '^screen' && exists('$TMUX')
    "set mouse+=a
    " tmux knows the extended mouse mode
    "set ttymouse=xterm2
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <Insert>=\e[2;*~"
    execute "set <Delete>=\e[3;*~"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <xF1>=\e[1;*P"
    execute "set <xF2>=\e[1;*Q"
    execute "set <xF3>=\e[1;*R"
    execute "set <xF4>=\e[1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif

if has('gui_running')
    colorscheme jaime
else
    colorscheme antares
    hi Normal ctermbg=none
endif

" Remap Esc to C-L, C-N
imap <C-L> <Esc>
imap <C-n> <Esc>

" Nicer tabs
nmap <C-t> :tabnew<CR>
nnoremap <C-h> :tabclose<CR>
nmap <C-S-Right> gt
nmap <C-S-Left> gT
nnoremap J gT
nnoremap K gt
nnoremap <M-PageUp> gT
nnoremap <M-PageDown> gt
inoremap <M-PageUp> <ESC>gT
inoremap <M-PageDown> <ESC>gt
nnoremap <M-Up> gT
nnoremap <M-Down> gt
inoremap <M-Up> <ESC>gT
inoremap <M-Down> <ESC>gt
nnoremap <silent> <M-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <M-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" nicer movement among windows
nnoremap <M-S-Left> <C-w><Left>
nnoremap <M-S-Right> <C-w><Right>
nnoremap <M-S-Up> <C-w><Up>
nnoremap <M-S-Down> <C-w><Down>
inoremap <M-S-Left> <Esc><C-w><Left>
inoremap <M-S-Right> <Esc><C-w><Right>
inoremap <M-S-Up> <Esc><C-w><Up>
inoremap <M-S-Down> <Esc><C-w><Down>

" leave Ex mode forever
nnoremap Q <nop>

" nicer movements
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
nnoremap <Home> g<Home>
nnoremap <End> g<End>
vnoremap <Home> g<Home>
vnoremap <End> g<End>
inoremap <Home> <C-o>g<Home>
inoremap <End> <C-o>g<End>
" keep Omnicomplete working when using better movements at the same time
inoremap <silent> <expr> <Up> pumvisible() ? "\<Up>" : "\<C-o>gk"
inoremap <silent> <expr> <Down> pumvisible() ? "\<Down>" : "\<C-o>gj"

filetype plugin on
filetype indent on
autocmd FileType python,perl,java,c,cpp,javascript,pandoc set colorcolumn=80,100 " highlight 80th and 100th column

" Insert, Cut and Paste with windows-like keys
" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>   	"+gP
map <S-Insert>  	"+gP

cmap <C-V>  	<C-R>+
cmap <S-Insert> 	<C-R>+

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert> 	<C-V>
vmap <S-Insert> 	<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>   	<C-V>

set ffs=unix,dos,mac  " also allow Mac line endings
behave xterm

" Editing TSVs
function TSV(tabwidth)
    let &ts = a:tabwidth
    let &sts= a:tabwidth
    set et!
    set nowrap
endfunction

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Strip trailing whitespace
nnoremap <F8> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
inoremap <F8> <Esc>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>i
autocmd BufWritePre *.py,*.pl,*.js :%s/\s\+$//e " make it automatic in Python, Perl, Javascript

" Nowrap/Wrap
nnoremap <leader>wn :windo set nowrap<CR>
nnoremap <leader>wy :windo set wrap<CR>

function ToggleWrap()
    if (&wrap == 1)
        windo set nowrap
    else
        windo set wrap
endif
endfunction
map <F2> :call ToggleWrap()<CR>
map! <F2> ^[:call ToggleWrap()<CR>

" line numbering
function ToggleNum()
    if (&number == 1)
        windo set nonumber
    else
        windo set number
endif
endfunction
map <S-F2> :call ToggleNum()<CR>
map! <S-F2> ^[:call ToggleNum()<CR>

" PerlTidy settings
autocmd FileType perl nnoremap <silent> <leader>t :%!perltidy -q -pbp -l=0 -ndnl -nola -ci=4<Enter>
autocmd FileType perl vnoremap <silent> <leader>t :!perltidy -q -pbp -l=0 -ndnl -nola -ci=4<Enter>


" highlight first match when typing a regexp
set incsearch

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif


" mapping Omnicomplete to Ctrl-Space (http://stackoverflow.com/questions/510503/ctrlspace-for-omni-and-keyword-completion-in-vim)
" (from Jedi-Vim)
inoremap <C-Space> <C-x><C-o>
inoremap <Nul> <C-x><C-o>
"imap <buffer> <Nul> <C-Space>
"smap <buffer> <Nul> <C-Space>

" CtrlP plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*/runs/*,*.so,*.swp,*.zip,*.pyc
let g:ctrlp_root_markers = ['Treex']
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

execute pathogen#infect()

" Syntastic plugin
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:syntastic_python_flake8_args='--ignore=E501,E225'
let g:syntastic_python_checkers=['flake8']
let g:syntastic_javascript_checkers = ['jshint']

let g:syntastic_mode_map = { "mode": "passive" }
nmap <F9> :SyntasticCheck<CR>
nmap <F10> :SyntasticReset<CR>

" Hex mode
" ex command for toggling hex mode - define mapping if desired
command -bar Hex call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" NERDTree Plugin settings
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeIgnore = ['\.pyc$']
map <C-n> :NERDTreeToggle<CR>

" Airline plugin settings
set laststatus=2
let g:airline_theme='molokai'

" Vim-jedi plugin settings
autocmd FileType python setlocal completeopt-=preview

" Vim-pandoc plugin settings
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#spell#enabled = 0

" disable auto indentation in LaTeX
autocmd FileType tex set noai nocin nosi inde=
" latex shortcuts
autocmd FileType tex imap [[i \begin{itemize}
autocmd FileType tex imap [[e \begin{enumerate}
autocmd FileType tex imap \i<space> \item 
autocmd FileType tex imap \ig<space> \includegraphics[width=]{}<esc>3hi
autocmd FileType tex imap \s<space> \section{}<left>
autocmd FileType tex imap \ss<space> \subsection{}<left>
autocmd FileType tex imap \r<space> \ref{}<left>
autocmd FileType tex imap \l<space> \label{}<left>
autocmd FileType tex imap [[t* \begin{textblock*}{}(,)<esc>3hi
autocmd FileType tex imap \o<space> \only<lt>><left>
autocmd FileType tex imap \v<space> \vspace{}<left>
autocmd FileType tex imap \h<space> \hspace{}<left>
autocmd FileType tex imap \hl<space> \hline

" tagbar plugin settings
nnoremap <silent> <C-b> :TagbarToggle<CR>
