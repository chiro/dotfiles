alias ls='ls --color=auto'

alias g='git'
alias b='git b'

function peco-select-history() {
    local -a reverse_command
    if command -v gtac >/dev/null 2>&1; then
        reverse_command=(gtac)
    elif command -v tac >/dev/null 2>&1; then
        reverse_command=(tac)
    else
        reverse_command=(tail -r)
    fi
    READLINE_LINE=$(HISTTIMEFORMAT='' history | "${reverse_command[@]}" | sed -e 's/^\s*[0-9]\+\s\+//' | awk '!a[$0]++' | peco --query "$READLINE_LINE")
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-r": peco-select-history'

function peco-ghq-cd() {
    local selected_file
    selected_file=$(ghq list --full-path | peco --query "${READLINE_LINE:-}")
    if [ -n "$selected_file" ]; then
        if [ -t 1 ]; then
            printf '%s\n' "${selected_file}"
            cd -- "${selected_file}" || return
        fi
    fi
}
alias gl=peco-ghq-cd

function peco-git-add() {
    local selected=$(git status -s | peco | awk '{print $2}')
    if [ -n "$selected" ]; then
        selected=$(tr '\n' ' ' <<< "$selected")
        git add $selected
    fi
}
alias gadd=peco-git-add

function peco-git-checkout () {
    local selected_branch=$(git branch --list --no-color | colrm 1 2 | peco)
    if [ -n "$selected_branch" ]; then
        selected=$(tr '\n' ' ' <<< "$selected_branch")
        git checkout $selected
    fi
}
alias gco=peco-git-checkout
