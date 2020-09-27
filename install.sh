#!/usr/bin/env sh
##
## EPITECH PROJECT, 2020
## vim-epitech
## File description:
## vim configuration installer
##

VIM_EPITECH_PATH=$HOME/.vim/epitech

add_to_vimrc() {
    if [ ! -f "~/.vimrc" ]; then
        touch $HOME/.vimrc
    fi

    grep -q "Epitech configuration" $HOME/.vimrc

    if [[ $? != 0 ]]; then
        echo "Epitech configuration path does not exist setting one..."
        cat >> "$HOME/.vimrc" << EOF
""
"" Epitech configuration
""

if !empty(glob("~/.vim/epitech/epitech.vim"))        
	source $VIM_EPITECH_PATH/epitech.vim
else
	echoerr "Cant find epitech.vim configuration file"
endif
EOF
    else
        echo "Epitech configuration path already exist"
        echo "Nothing more to do..."
    fi
}

install() {
    echo "Installing Vim configuration"

    echo "Making sure "$VIM_EPITECH_PATH"  exists"
    mkdir -p $VIM_EPITECH_PATH

    if [ -f "$VIM_EPITECH_PATH/epitech.vim" ]; then
        echo "Replacing epitech.vim with the new one"
    fi
    cp epitech.vim $VIM_EPITECH_PATH/epitech.vim   
    add_to_vimrc

    echo "epitech-vim sucessfully installed"
}

install
