#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set a colored PS1 if TERM supports it
case "$TERM" in
    xterm-color|*-256color) PS1='\[\e[91;1;2m\]\u@\h\[\e[0m\]:\[\e[96m\]\w\[\e[0m\]\$ ';;
    *) PS1='[\u@\h \W]\$ ';;
esac

# History settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=100000
shopt -s cmdhist

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

. "$HOME/.cargo/env"
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
eval "$(uv generate-shell-completion bash)"
