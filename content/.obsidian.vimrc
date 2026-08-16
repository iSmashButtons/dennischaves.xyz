" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
" I like using H and L for beginning/end of line
nmap H ^
nmap L $
" Quickly remove search highlights
nmap <F9> :nohl<CR>

" Yank to system clipboard
set clipboard=unnamed

" Also works
nmap <C-w>h :obcommand<space>workspace:split-horizontal<CR>

" jk exits insert mode
imap jk <Esc>
