alias g='git'
alias b='git b'

function peco-select-history() {
    local tac
    which gtac &> /dev/null && tac="gtac" || \
            which tac &> /dev/null && tac="tac" || \
                    tac="tail -r"
    READLINE_LINE=$(HISTTIMEFORMAT= history | $tac | sed -e 's/^\s*[0-9]\+\s\+//' | awk '!a[$0]++' | peco --query "$READLINE_LINE")
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-r": peco-select-history'

function peco-ghq-cd() {
    local selected_file=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_file" ]; then
        if [ -t 1 ]; then
            echo ${selected_file}
            cd ${selected_file}
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
