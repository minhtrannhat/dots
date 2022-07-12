# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi
# Put your fun stuff here.

export KITTY_ENABLE_WAYLAND=1

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export GPG_TYY=$(tty)

alias rm='rm -i'
alias nnn='nnn -e'
alias magit='emacs -nw --eval "(magit-status)"'
alias emac='emacsclient -nw'

gpgconf --launch gpg-agent

export EDITOR=/home/minhradz/.local/bin/lvim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export MANPAGER="lvim +Man!"
export LC_ALL=en_US.UTF-8

eval "$(direnv hook bash)"
eval "$(starship init bash)"
export PATH="/home/minhradz/.cargo/bin;/home/minhradz/.local/bin;/home/minhradz/go/bin;/home/minhradz/.cabal/bin:$PATH"

[ -f "/home/minhradz/.ghcup/env" ] && source "/home/minhradz/.ghcup/env"
