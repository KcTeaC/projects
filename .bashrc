#
## ============================================ ##
# | >> .bashrc
## -------------------------------------------- ##

## ================================ ##
# | >>Path
## -------------------------------- ##

#
if [[ -d "$HOME/.local/bin" ]]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

#
## ================================ ##
# | >> Editor
## -------------------------------- ##
#

if which vim &>/dev/null; then
	export EDITOR='vim'
	export SUDO_EDITOR='vim'
else
	export EDITOR='nano'
	export SUDO_EDITOR='nano'
fi

#
## ================================ ##
# | >> Term
## -------------------------------- ##
#

export TERM='xterm-256color'

#
## ================================ ##
# | >>LS
## -------------------------------- ##
#

export LS_COLORS='di=01;31:fi=37:ln=01;36:ex=01;32:*.bd=40;33;01:*.cd=40;33;01:*.or=40;33;01:*.tar.bz2=01;31:*.tar.gz=01;31:*.tar.xz=01;31:*.tar=01;31:*.tbz2=01;35:*.tgz=01;35:*.txz=01;35:*.bz2=01;34:*.gz=01;34:*.xz=01;34'

#
## ================================ ##
# | >> History
## -------------------------------- ##
#

export HISTTIMEFORMAT='%F %T'
export HISTCONTROL='ignoreboth:erasedups'
export HISTSIZE=4096
export HISTIGNORE='bg:fg:ls:ll:la:clear:history:exit'

shopt -s histappend
shopt -s cmdhist

#
## ================================ ##
# | >> Settings and options
## -------------------------------- ##
#

set -o noclobber

shopt -s cdspell	# correct minor spellng errors passed to cd
shopt -s extglob
shopt -s globstar	# recursive globbing
shopt -s nocaseglob	# case insensitive globbing

#
## ================================ ##
# | >> Aliases
## -------------------------------- ##
#
alias ..='cd ../'
alias bin='cd ~/.local/bin'
alias pkgs='cd ~/usr/packages'
alias hsk='cd ~/etc/xmonad'
alias config='usr/bin/git --git-dir=/home/admin/etc/projects --work-tree=/home/admin'

alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias v=v'vim'
alias g='git'
alias count='pacman -Qq | wc -l'
alias list='pacman -Q | less'
alias c='clear'
alias bc='bc -l'
alias df='df -h'
alias du='du -c -h'

if [[ $EUID != "0" ]]; then
        alias sudo='sudo '
        alias snano='sudo nano'
        alias svim='sudo vim'
        alias smake='sudo make'
        alias smakein='sudo make install'
        alias scat='sudo cat'
        alias schown='sudo schown'
        alias smount='sudo mount'
        alias pacman='sudo pacman'
        alias halt='sudo halt'
        alias reboot='sudo reboot'
        alias shutdown='sudo shutdown'
fi

# Ls
alias ls='ls --color=always'

# print each path on a separate line
alias path='echo -e ${PATH//:/\\n}'
#
## ================================ ##
# | >> Functions
## -------------------------------- ##
#

# Convert string(s) to lower case
_goLow() {
	local str="$@"
	local output
	output=$(tr '[A-Z]' '[a-z]'<<<"${str}")
	echo $output
}

# Convert string(s) to upper case
_goHi() {
	local str="$@"
	local output
	output=$(tr '[A-Z]' '[a-z]'<<<"${str}")
	echo $output
}

# Cd and LS in one

_cd() {
	cd "$*" && ls
}

# Archive extraction utility
_extract() {
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
				tar xvf $1
				;;
			*.bz2)
				bunzip2 $1
				;;
			*.gz)
				gunzip $1
				;;
			*.xz)
				unxz $1
				;;
			*.rar)
				unrar e $1
				;;
			*.zip)
				unzip $1
				;;
			*.Z)
				uncompress $1
				;;
			*.7z)	
				7z x $1
				;;
			*)
				echo "unknown archive method"
		esac
	else
		echo "'$1' - file does not exist"
	fi
}
