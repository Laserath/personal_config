" set color scheme
:sy on
filetype on
syntax on
colorscheme desert

set backspace=2
set backspace=indent,eol,start

" turn on pathogen for gradle syntax highlighting
" call pathogen#infect()
" call pathogen#helptags()

" turn on line numbering
:set number
:set lbr!

" set shiftwidth so that >> works correctly
:set shiftwidth=4

" set maximum chars in a line
" set tw=78

" have a small-ish yet readable font:
set guifont=Hack:h10

" have error messages red on white
" readable in the above font):
highlight ErrorMsg guibg=White guifg=Red

" enable highlight search
set hls

" set so a tab is 4 space characters
set tabstop=4
set expandtab
set autoindent
set cursorline

" have pymode ignore specific lint settings
"let g:pymode_lint_options_mccabe = { 'complexity': 1000000 }

" Commenting blocks of code.
" autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
" autocmd FileType sh,ruby,python   let b:comment_leader = '# '
" autocmd FileType conf,fstab       let b:comment_leader = '# '
" autocmd FileType tex              let b:comment_leader = '% '
" autocmd FileType mail             let b:comment_leader = '> '
" autocmd FileType vim              let b:comment_leader = '" '
" noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
" noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
"

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
