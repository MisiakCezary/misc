set ignorecase
set hlsearch
set number
set relativenumber
set path=**
set incsearch
set wildoptions=pum
highlight LineNr ctermfg=grey
let g:netrw_banner=0
syntax on

set tabstop=4
set wildignore=*.exe,*.dll,*.pdb,*.log,*.pak,*.zip,*.rar,*.7z

let g:mapleader=" "

" Find file
nnoremap <leader>f :find 
vnoremap <leader>f "9y:find <C-r>9

" Grep
nnoremap <leader>g :grep -iIR '' **<C-Left><C-Left><Right>
nnoremap <leader>G :grep -IR '' **<C-Left><C-Left><Right>
vnoremap <leader>g "9y:grep -IR '<C-r>9' **
vnoremap <leader>G "9y:grep -iIR '<C-r>9' **

" Replace
nnoremap <leader>r :%s//g<Left><Left>
nnoremap <leader>R :%s//gc<Left><Left><Left>
vnoremap <leader>r "9y:%s/<C-r>9//g<Left><Left>
vnoremap <leader>R "9y:%s/<C-r>9//gc<Left><Left><Left>

" Buffer navigation
map <F2> :bp<CR>
imap <F2> <Esc>:bp<CR>
tmap <F2> <C-W>:bp<CR>
map <F3> :bn<CR>
imap <F3> <Esc>:bn<CR>
tmap <F3> <C-W>:bn<CR>
" Buffer deletion
map <F4> :bd<CR>
imap <F4> <Esc>:bd<CR>
" Buffer list
map <F5> :ls<CR>
imap <F5> <Esc>:ls<CR>
tmap <F5> <C-W>:ls<CR>

" Quickfix list navigation
map <F6> :cp<CR>
imap <F6> <Esc>:cp<CR>
map <F7> :cn<CR>
imap <F7> <Esc>:cn<CR>
map <F8> :copen<CR>
imap <F8> <Esc>:copen<CR>

" Auto ctags -r path - define extensions
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c,*.py call UpdateTags()
