#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

#PS1='[\u@\h \W]\$ '
export PS1=$'┏━\[\e[1;36m\][\[\e[1;32m\]\u\[\e[1;36m\]@\[\e[1;33m\]\h \[\e[1;36m\](\[\e[1;31m\]\T\[\e[1;36m\]) \[\e[1;34m\]\W\[\e[1;36m\]]\[\e[1;31m\]\$\[\e[0m\]\n┗━\[\e[1;31m\][$(if [[ $? == 0 ]]; then echo $"\[\e[1;32m\]✓"; else echo "✗"; fi)\[\e[1;31m\]] → \[\e[0m\]'

alias ls='ls --color=auto'

alias em='emacs'
alias ra='ranger'

alias reinst='clear && source /etc/profile && source /etc/bash.bashrc && source $HOME/.bashrc'

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
