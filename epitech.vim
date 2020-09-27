""
""  EPITECH PROJECT, 2020
""  Vim Epitech
""  File description:
""  A Vim configuration for the Epitech curriculum
""

syntax on

" Numbers on the left
set title

" Show line and column on the bottom right
set ruler

" Identation settings
set tabstop=4
set shiftwidth=4
set expandtab
set ai
set si

" Set unix format for carriage returns
set fileformat=unix

" Considerate a *.h as *.c
autocmd BufNewFile,BufRead *.h set filetype=c

if (&ft == 'c') || (&ft == 'cpp')
    setlocal comments=s:/*,m:**,ex:*/
endif

" Epitech Header

let s:comMapNoShebang = {
            \ 'c': {'b': '/*', 'm': '**', 'e': '*/'},
            \ 'cpp': {'b': '//', 'm': '//', 'e': '//'},
            \ 'make': {'b': '##', 'm': '##', 'e': '##'},
            \ 'java': {'b': '//', 'm': '//', 'e': '//'},
            \ 'latex': {'b': '%%', 'm': '%%', 'e': '%%'},
            \ 'html': {'b': '<!--', 'm': '  --', 'e': '-->'},
            \ 'lisp': {'b': ';;', 'm': ';;', 'e': ';;'},
            \ 'css': {'b': '/*', 'm': '**', 'e': '*/'},
            \ 'pov': {'b': '//', 'm': '//', 'e': '//'},
            \ 'pascal': {'b': '{ ', 'm': '   ', 'e': '}'},
            \ 'haskell': {'b': '{-', 'm': '-- ', 'e': '-}'},
            \ 'vim': {'b': '""', 'm': '"" ', 'e': '""'},
            \}

let s:comMapShebang = {
            \ 'sh': {'s': '#!/usr/bin/env sh', 'b': '##', 'm': '##', 'e': '##'},
            \ 'bash': {'s': '#!/usr/bin/env bash', 'b': '##', 'm': '##', 'e': '##'},
            \ 'zsh': {'s': '#!/usr/bin/env zsh', 'b': '##', 'm': '##', 'e': '##'},
            \ 'php': {'s': '#!/usr/bin/env php', 'b': '/*', 'm': '**', 'e': '*/'},
            \ 'perl': {'s': '#!/usr/bin/env perl', 'b': '##', 'm': '##', 'e': '##'},
            \ 'python': {'s': '#!/usr/bin/env python3', 'b': '##', 'm': '##', 'e': '##'},
            \ 'ruby': {'s': '#!/usr/bin/env ruby', 'b': '##', 'm': '##', 'e': '##'},
            \ 'node': {'s': '#!/usr/bin/env node', 'b': '/*', 'm': '**', 'e': '*/'},
            \}

function! s:Epiyear()
    let old_time = v:lc_time
    language time en_US.utf8
    let str = strftime("%Y")
    exec 'language time '.old_time
    return str
endfunction

function! s:InsertFirst()
    call inputsave()
    let proj_name = input('Enter project name: ')
    let file_desc = input('Enter file description: ')
    call inputrestore()
    1,6s/µPROJECTNAMEµ/\= proj_name/ge
    1,6s/µYEARµ/\= s:Epiyear()/ge
    1,6s/µFILEDESCµ/\= file_desc/ge
endfunction

function! s:IsSupportedFt()
    return has_key(s:comMapNoShebang, &filetype)
endfunction

function! s:IsSupportedFtShebang()
    return has_key(s:comMapShebang, &filetype)
endfunction

function! Epi_header()
    if s:IsSupportedFt()
        let Has_Shebang = 0
    elseif s:IsSupportedFtShebang()
        let Has_Shebang = 1
    else
        echoerr "Epitech header: Unsupported filetype: " . &filetype . " If you think this an error or you want an additional filetype please contact me :)"
        return
    endif

    if Has_Shebang == 0
        let l:bcom = s:comMapNoShebang[&filetype]['b']
        let l:mcom = s:comMapNoShebang[&filetype]['m']
        let l:ecom = s:comMapNoShebang[&filetype]['e']

        let l:ret = append(0, l:bcom)
        let l:ret = append(1, l:mcom . " EPITECH PROJECT, µYEARµ")
        let l:ret = append(2, l:mcom . " µPROJECTNAMEµ")
        let l:ret = append(3, l:mcom . " File description:")
        let l:ret = append(4, l:mcom . " µFILEDESCµ")
        let l:ret = append(5, l:ecom)
    else
        let l:scom = s:comMapShebang[&filetype]['s']
        let l:bcom = s:comMapShebang[&filetype]['b']
        let l:mcom = s:comMapShebang[&filetype]['m']
        let l:ecom = s:comMapShebang[&filetype]['e']

        let l:ret = append(0, l:scom)
        let l:ret = append(1, l:bcom)
        let l:ret = append(2, l:mcom . " EPITECH PROJECT, µYEARµ")
        let l:ret = append(3, l:mcom . " µPROJECTNAMEµ")
        let l:ret = append(4, l:mcom . " File description:")
        let l:ret = append(5, l:mcom . " µFILEDESCµ")
        let l:ret = append(6, l:ecom)
    endif
    call s:InsertFirst()
    :8
endfunction

command! EpiHeader call Epi_header()

" Compile command

function! Compile()
    let b:ccommand = "make"
    echohl Question
    let b:ccommand = input("compile : ", b:ccommand)
    echohl None

    let &makeprg = b:ccommand
    exec "make"
endfunction

command! -nargs=0 Compile call Compile()

" Goto line command

function! GotoLine()
    let b:gotoline_n = ""
    echohl Question
    let b:gotoline_n = input("Goto Line : ", b:gotoline_n)
    echohl None

    exec b:gotoline_n
endfunction

command! -nargs=0 GotoLine call GotoLine()

" Global bindings
nnoremap <C-c><C-h> :EpiHeader<CR>
nnoremap <C-c><C-c> :w <bar> Compile<CR>
nnoremap <C-g> :GotoLine<CR>
