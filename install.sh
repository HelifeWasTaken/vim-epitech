#!/usr/bin/env sh
##
## EPITECH PROJECT, 2020
## vim-epitech
## File description:
## vim configuration installer
##

VIM_EPITECH_PATH=""

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
	echo
	echo "To install for a specifc user use ./install.sh specific_user user_name"
    echo "It requires that the user has his home folder as /home/user_name"
}

case "$1" in
	specific_user)
		folder="/home/$2"
		user="$2"
		VIM_EPITECH_PATH="$folder/.vim/epitech.vim"

		if [ "$folder" = "$user" ]; then
			echo "Missing parameter for user" 1>&2
		fi

		if [ ! -d "$folder" ]; then
			echo "Can't find $folder for $user" 1>&2
		fi

		mkdir -p "$folder/.vim"

		install "$folder/.vimrc"

		chown -R "$user:$user" "$folder/.vim"
		chown "$user:$user" "$folder/.vimrc"
		chmod 755 "$folder/.vim"
		chmod 666 "$folder/.vim/epitech.vim"
		chmod 666 "$folder/.vimrc"
		;;

	local)
		$0 specific_user "$(whoami)"
		exit $?
		;;

	system)
		for dir in /home/* ; do
			cuser="$(echo $dir | cut -d '/' -f 3)"
			$0 specific_user "$cuser"
		done

		mkdir -p "/root/.vim"
		VIM_EPITECH_PATH="/root/.vim/epitech.vim"
		install "/root/.vimrc"
		;;

	*)
		usage
		;;
esac
