function tree() {
    find . -print | sed -e 's;[^/]*/;|__;g;s;__|; |;g'
}

alias npo='|& tee out.txt'

alias apo='|& tee -a out.txt'

alias ls="ls -altrF --color=auto"


