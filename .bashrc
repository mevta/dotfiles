#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
set -o vi
bind -m vi-command ".":insert-last-argument
bind -m vi-insert "\C-l.":clear-screen
bind -m vi-insert "\C-a.":beginning-of-line
bind -m vi-insert "\C-e.":end-of-line
bind -m vi-insert "\C-w.":backward-kill-word

set runtimepath=~/.vim,$VIM/vimiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
export PATH="$PATH:`yarn global bin`"
export PATH="$PATH:/opt/yarn-[version]/bin"
colors() {
        local fgc bgc vals seq0

        printf "Color escapes are %s\n" '\e[${value};...;${value}m'
        printf "Values 30..37 are \e[33mforeground colors\e[m\n"
        printf "Values 40..47 are \e[43mbackground colors\e[m\n"
        printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

        # foreground colors
        for fgc in {30..37}; do
                # background colors
                for bgc in {40..47}; do
                        fgc=${fgc#37} # white
                        bgc=${bgc#40} # black

                        vals="${fgc:+$fgc;}${bgc}"
                        vals=${vals%%;}

                        seq0="${vals:+\e[${vals}m}"
                        printf "  %-9s" "${seq0:-(default)}"
                        printf " ${seq0}TEXT\e[m"
                        printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
                done
                echo; echo
        done
}

alias ls='ls --color=auto -a'

PS1='[\W]\$ '

export LANG=en_US.UTF-8
export LC_MESSAGES="C"

alias inek="ssh -p 8085 e2086825@external.ceng.metu.edu.tr"

unzipd () {
    
    mkdir -p "${1%%.*}"
    case ${1##*.} in
            zip|jar)
                 unzip "$1" 
                 ;;
            rar)
                   unrar x "$1" "${1%%.*}"
                   ;;
            7z)
                   7z x -o{$1%%.*} "$1"
                   ;;
            *)
                 tar xvf "$1" -C "${1%%.*}"
                 ;;
esac
    rm -rf "$1"
}
unzipm () {
    
    mkdir -p "${1%%.*}"
    case ${1##*.} in
            zip|jar)
                 unzip "$1" -d "${1%%.*}"
                 ;;
            rar)
                   unrar x "$1" "${1%%.*}"
                   ;;
            7z)
                   7z x -o{$1%%.*} "$1"
                   ;;
            *)
                 tar xvf "$1" -C "${1%%.*}"
                 ;;
esac
    mv "$1" "$2"
}
