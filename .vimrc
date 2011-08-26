set nocompatible

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin


" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>        "+gP

nm \\paste\\ "=@*.'xy'<CR>gPFx"_2x:echo<CR>
imap <C-V> x<Esc>\\paste\\"_xa
vmap <C-V> "-cx<Esc>\\paste\\"_x
cmap <C-V>        <C-R>+

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>        <C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>        :update<CR>
inoremap <C-S>        <C-O>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
inoremap <C-Z> <C-O>u

" CTRL-A is Select all
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG


" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]
set formatoptions=
set encoding=utf-8
set fencs=ucs-bom,utf-8,cp1250
set shiftwidth=4
set softtabstop=4
set expandtab
set visualbell
set noerrorbells
set ignorecase
set smartcase
set viminfo='800,f1,:100,/100
set smarttab
set autoindent
set nocindent
set smartindent
set ruler
set incsearch        " do incremental searching
set whichwrap=<,>,h,l
set guioptions=a
set backspace=2
set history=50
set wildmenu
set wildmode=list:longest,full
set nobackup
set langmenu=none
set guioptions-=T
set exrc " read _vimrc in current directory
set textwidth=76
set scrolloff=5
set spelllang=en_us
syntax on
set hlsearch
set noswapfile
" don't loose undo stack when leaving the buffer (edited file)
set hidden
set showcmd
" switching buffers
set autowriteall
set foldmethod=marker
set complete-=i "do not search included files for keywords to complete
set clipboard+=unnamed
set diffopt+=vertical
" //set number
set co=80
set lines=83
set nohidden

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]


if has("unix")
  set shcf=-ic
endif

let mapleader = ","
let $ADDED = '~/.vim/added'
if has("win32")
  let $ADDED = $VIM.'/vimfiles/added'
endif
nmap <C-l> :cn<return>
nmap <c-j> <C-^>

" smart tab completition
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    elseif "forward" == a:direction
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction





inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>
inoremap <c-tab> <c-r>=InsertTabWrapper ("startkey")<cr>

" jump out of brackets, very useful with brackets autoclose
imap <c-l> <right>

" I sometime miss ctrl-[
inoremap <C-p> <Esc>

" Pull word under cursor into LHS of a substitute
nmap <C-h> :%s#\<<c-r>=expand("<cword>")<cr>\>#

" Pull Visually Highlighted text into LHS of a substitute
vmap <c-h> y:%s/<C-R>"/

"cwindow quickfix
map <Leader>cc :cwindow<cr>:cc<cr><c-w>b<cr>
map <Leader>cn :cwindow<cr>:cn<cr><c-w>b<cr>
map <Leader>cp :cwindow<cr>:cp<cr><c-w>b<cr>

command! -bang SvnDiff ::diffsplit %:p:h/.svn/text-base/%:t.svn-base<cr>

vnoremap r <Esc>`.``gvP``p

"please correct me next time :)
iabbr improt import

let g:EnhCommentifyUseAltKeys = 'yes'
let g:EnhCommentifyFirstLineMode = 'yes'

"dont move cursor after pressing .
noremap . md.`d

function! ExtractVariable()
    let name = inputdialog("name please")
    if name != ""
        execute "normal O" . name . " = "
        normal p
        execute (line('.')+1) . ",$s/" . escape(getreg('"'), '/\') . "/" . name . "/"
    endif
endfunction

noremap <A-v> y:call ExtractVariable()<cr>

nmap  s <Plug>Ysurround
nmap  S <Plug>YSurround

" read in the machine specific configuration
source ~/.hostvimrc

" without this abbrev ,b does not work from hs files (WTF)
let g:fuf_abbrevMap  = {
      \   "^ALL" : [
      \     "**/",
      \   ],
      \ }
nnoremap <silent> ,f :FufCoverageFileChange<CR>
nnoremap <silent> ,t :FufTag<CR>
nnoremap <silent> ,b :FufBuffer<CR>
" fuzzy finder file in the current buffers' dir
nnoremap <silent> ,e :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> ,r :FufRenewCache<CR>

let g:fuf_file_exclude="\v\~$|\.(o|exe|dll|bak|class|sw[po])$|(^|[/\\])\.(hg|git|bzr)($|[/\\])"
let g:fuf_dir_exclude="\v(^|[/\\])\.(hg|git|bzr)($|[/\\])"

nnoremap <silent> <C-]> :tj <s-c-r>=expand('<cword>')<cr><cr>

command RemoveTrailingWhitespace %s/\( |\t\)\+$//g | noh
command RemoveBRs %s/<br \/>/\n/g
noremap <silent> <C-b> :RemoveBRs

au BufEnter *.hs compiler ghc
let g:haddock_browser="firefox"

colorscheme desert
noremap <A-S-w> c<p><C-R>"</p><ESC>

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

nnoremap JJJJ <Nop>

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" Set off the other paren
highlight MatchParen ctermbg=4



"Functions

"Open URL in browser

function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!konqueror ".line
endfunction

"

"Paste Toggle
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
"

"Todo List Mode

function! TodoListMode()
   e ~/.todo.otl
   Calendar
   wincmd l
   set foldlevel=1
   tabnew ~/.notes.txt
   tabfirst
   " or 'norm! zMzr'
endfunction


"{{{ Mappings

" Open Url on this line with the browser \w
map <Leader>w :call Browser ()<CR>

" Open the Project Plugin <F2>
nnoremap <silent> <F2> :Project<CR>

" Open the Project Plugin
nnoremap <silent> <Leader>pal  :Project .vimproject<CR>

" TODO Mode
nnoremap <silent> <Leader>todo :execute TodoListMode()<CR>

" Open the TagList Plugin <F3>
nnoremap <silent> <F3> :Tlist<CR>

" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" DOS is for fools.
nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

" Paste Mode!  Dang! <F10>
nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Edit gvimrc \gv
nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.gvimrc<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Good call Benjie (r for i)
nnoremap <silent> <Home> i <Esc>r
nnoremap <silent> <End> a <Esc>r

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Testing
set completeopt=longest,menuone,preview

inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" Fix email paragraphs
nnoremap <leader>par :%s/^>$//<CR>

"ly$O#{{{ "lpjjj_%A#}}}jjzajj

"}}}

"{{{Taglist configuration
let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0
"}}}

let g:rct_completion_use_fri = 1
"let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_ViewRule_pdf = "kpdf"

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap ff <Esc>
