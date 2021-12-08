let s:livesplit_enable    = v:false
let s:livesplit_address   = 'localhost:16834'
let s:livesplit_recording = v:false
let s:crlf                = nr2char(0x0d) . nr2char(0x0a)

function! s:initial_settings() abort
  if !isdirectory('share/vim-duzzle')
    let gitout = system('git clone https://github.com/deris/vim-duzzle share/vim-duzzle')
    if v:shell_error !=# 0
      throw gitout
    endif
  endif

  let conf                = json_decode(join(readfile('conf/config.json'), "\n"))
  let s:livesplit_enable  = get(conf, 'livesplit_enable', v:false)
  let s:livesplit_address = get(conf, 'livesplit_address', 'localhost:16834')
  if s:livesplit_enable
    augroup livesplit
      autocmd!
      autocmd FileType duzzle
      \ call s:livesplit_on_duzzle_start()
      autocmd FileType *
      \ call s:livesplit_on_duzzle_end()
    augroup END
  endif

  set rtp+=share/vim-duzzle
  silent source share/vim-duzzle/plugin/duzzle.vim
  syntax enable
  filetype plugin indent on
endfunction

function! s:livespit_send_request(cmds) abort
  let ch = ch_open(s:livesplit_address)
  call ch_sendraw(ch, join(map(copy(a:cmds), {_, cmd -> cmd . s:crlf}), ''))
  call ch_close(ch)
endfunction

function! s:livesplit_on_duzzle_start() abort
  if !s:livesplit_recording
    call s:livespit_send_request(['reset', 'starttimer'])
    let s:livesplit_recording = v:true
    augroup livesplit_started
      autocmd!
      autocmd BufDelete <buffer>
      \ call s:livesplit_on_duzzle_suspend()
    augroup END
  endif
endfunction

function! s:livesplit_on_duzzle_end() abort
  if s:livesplit_recording && &filetype ==# ''
    call s:livespit_send_request(['split'])
    let s:livesplit_recording = v:false
    augroup livesplit_started
      autocmd!
    augroup END
  endif
endfunction

function! s:livesplit_on_duzzle_suspend() abort
  if s:livesplit_recording
    call s:livespit_send_request(['pause'])
    let s:livesplit_recording = v:false
    augroup livesplit_started
      autocmd!
    augroup END
  endif
endfunction

try
  call s:initial_settings()
catch
  echomsg v:exception
  call input('Press ENTER or type command to continue')
  cquit!
endtry
