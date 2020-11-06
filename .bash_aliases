function tree() {
    find . -print | sed -e 's;[^/]*/;|__;g;s;__|; |;g'
}

alias npo='|& tee out.txt'
alias apo='|& tee -a out.txt'
alias ls="ls -altrF --color=auto"

alias vi="vim"
alias vimrc="vim ~/.vimrc"
alias v="vim"
alias tmux="tmux -2"
alias tmux2="tmux -2 new-session\; split-window -h \; split-window -v \"python3\" \;"

alias wtc="curl --silent 'http://whatthecommit.com/index.txt'"

alias docker="podman"
