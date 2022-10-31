#!/usr/bin/env sh
##
## EPITECH PROJECT, 2020
## vim-epitech
## File description:
## vim configuration installer
##

VIM_EPITECH_PATH=/etc/vim/epitech.vim
VIMRC_SYSTEM_WIDE=/etc/vim/vimrc.local
VIMRC_LOCAL="/home/$(whoami)/.vimrc"

add_configuration_to_file() {
    grep -q "source $VIM_EPITECH_PATH" "$1"

    if [[ $? != 0 ]]; then
        echo "Epitech configuration path does not exist setting one..."
        cat >> "$1" << EOF
""
"" Epitech configuration
""

if filereadable(glob("$VIM_EPITECH_PATH"))        
	source $VIM_EPITECH_PATH
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

    mkdir -p /etc/vim && cp epitech.vim "$VIM_EPITECH_PATH"

    add_configuration_to_file "$1"

    echo "epitech-vim sucessfully installed"
}

case "$1" in
  local )
	install "$VIMRC_LOCAL"
  ;;
  system )
	install "$VIMRC_SYSTEM_WIDE"
  ;;
  * )
	usage
  ;;
esac
