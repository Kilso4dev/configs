
#function task {
#    if [ "$#" -gt 0 ]; then
#	/bin/task "$@" ; /bin/task
#    else
#	/bin/task
#    fi   
#}

#alias pip-upgrade="sudo pip install -U $(pip freeze | cut -d '=' -f 1)"

alias ra='ranger'

alias v='vim'

alias rvim='sudo -E vim'

alias emacs='emacs -nw'

alias em='emacs'

function python-math {
    [ -f $HOME/.pythonstartup ] && export PYTHONSTARTUP=$HOME/.pythonstartup ; python $@; unset PYTHONSTARTUP
}

alias reinst='clear && source ~/.bashrc'
alias i3reinst='i3-msg restart'

alias filepath='readlink -f '
alias rm='rm -I'

alias git-tree='git log --oneline --graph --decorate --all'
alias keyboard='setxkbmap -layout'
#function git-com-push {
#    git commit -m $1 && git push $2 $3 
#}

#function  adapter-out-above {
#	xrand
#}
AdapterRes=1920x1080
AdapterName=DP1

alias display-DP1-above='xrandr --output "$AdapterName" --mode "$AdapterRes" --above eDP1'
alias display-DP1-left='xrandr --output "$AdapterName" --mode "$AdapterRes" --below eDP1'
alias display-DP1-right='xrandr --output "$AdapterName" --mode "$AdapterRes" --right-of eDP1'
alias display-DP1-below='xrandr --output "$AdapterName" --mode "$AdapterRes" --left-of eDP1'
alias display-DP1-same='xrandr --output "$AdapterName" --mode "$AdapterRes" --same-as eDP1'
alias display-DP1-off='xrandr --output "$AdapterName" --off'

function unzip-zip {
	unzip -a "$@"
}

function unzip-xz {
	xz --decompress "$@"
}

function unzip-tar {
	tar -xvf "$@"
}

function unzip-tar-gz {
	tar -xzvf "$@"
}

function unzip-tar-bz2 {
	tar -xjvf "$@"
}
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

alias load-vid-lpb='sudo modprobe v4l2loopback'
alias unload-vid-lpb='sudo rmmod v4l2loopback'



neofetch

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
