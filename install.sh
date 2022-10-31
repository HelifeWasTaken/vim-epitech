#!/usr/bin/env sh
##
## EPITECH PROJECT, 2020
## vim-epitech
## File description:
## vim configuration installer
##

VIMRC_DEFAULT_SYSTEM=/etc/vim/vimrc
VIMRC_SYSTEM_WIDE=/etc/vim/vimrc.local
VIMRC_LOCAL="/home/$(whoami)/.vimrc"

ensure_system_wide_config() {
	grep "source $VIMRC_SYSTEM_WIDE" "$VIMRC_DEFAULT_SYSTEM"

	if [ $? != 0 ]; then
		echo "Setup global vimrc"
		touch "$VIMRC_DEFAULT_SYSTEM"
		chmod 666 "$VIMRC_DEFAULT_SYSTEM"

		echo "source $VIMRC_SYSTEM_WIDE"  >> $VIMRC_DEFAULT_SYSTEM
	fi
}

add_configuration_to_file() {
    grep "source $VIM_EPITECH_PATH" "$1"

    if [ $? != 0 ]; then
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

    touch "$1"
    cp epitech.vim "$VIM_EPITECH_PATH"

    add_configuration_to_file "$1"

    echo "epitech-vim sucessfully installed"
}

usage() {
	echo "To install in local use ./install.sh local"
	echo
	echo "To install on the system use ./install.sh system"
}

case "$1" in
  local )
	VIM_EPITECH_PATH="$HOME/vim/epitech.vim"
	mkdir -p "$HOME/vim"
	install "$VIMRC_LOCAL"
  ;;
  system )
	mkdir -p /etc/vim
	ensure_system_wide_config
	VIM_EPITECH_PATH="/etc/vim/epitech.vim"
	install "$VIMRC_SYSTEM_WIDE"
  ;;
  * )
	usage
  ;;
esac
