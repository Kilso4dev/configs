# Session:
if [ -n "$DESKTOP_SESSION" ];then
	    eval $(gnome-keyring-daemon --start)
	        export SSH_AUTH_SOCK
fi


function ranger {
    /bin/ranger --choosedir=$HOME/.rangerdir $@; LASTDIR=`cat ~/.rangerdir`; cd "$LASTDIR"
}


function colors {
    for x in {0..8}; do 
	for i in {30..37}; do 
            for a in {40..47}; do 
		echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
            done
            echo
	done
    done
    echo ""
}

function display-set {
    case $2 in
	above)
	    xrandr --output "$1" --mode "$4" --above "$3" ${@:5}
	    ;;
	left)
	    xrandr --output "$1" --mode "$4" --left-of "$3" ${@:5}
	    ;;
	right)
	    xrandr --output "$1" --mode "$4" --right-of "$3" ${@:5}
	    ;;
	below)
	    xrandr --output "$1" --mode "$4" --below "$3" ${@:5}
	    ;;
	same)
	    xrandr --output "$1" --mode "$4" --same-as "$3" ${@:5}
	    ;;
	off)
	    xrandr --output "$1" --off ${@:3}
	    ;;
	fps)
	    xrandr --output "$1" -r "$3" ${@:4}
   esac

   sleep 1 && i3-msg restart
}

function runlutris {
    lutris lutris:rungameid/$1 ${@:2}
}

alias load-audio-loop='pactl load-module module-loopback'
alias unload-audio-loop='pactl unload-module module-loopback'
alias reload-wifi='sudo rmmod rtw88_8822be ; sudo modprobe rtw88_8822be'

function loopback-audio {
	arecord -Dhw:$1,$2 -c $3 -f cd | aplay -Dhw:$4,$5

}

alias audio-list='aplay -l'

alias pacman='sudo pacman'

alias la='ls -la'
alias v='nvim'
alias git-tree='git log --graph --oneline --all'

alias displays='xrandr'

alias filepath='readlink -f'
alias rm='rm -I'

alias view3D='osgviewer --window 0 0 1280 720'

alias i3reinst='i3-msg restart'
alias i3conf='$EDITOR ~/.config/i3/config'

shopt -s extglob


source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

source ~/.arduino15/arduino-cli-completion.sh

if [ ! -z "$PS1" ]; then
	neofetch
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# [portal] Do not manually edit the following lines!
# [portal] Activate bash completion for ZIB Portal CLI
#. ./.portal/portal-complete.sh
