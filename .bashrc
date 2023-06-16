
# locale
export LC_ALL="en_US.UTF-8"

COLOR='1;32'  # green, change to your liking
export PS1='\[\033['$COLOR'm\]\h\[\033[0m\]:\[\033[0;34m\]\w\[\033[0m\]\$ '


alias ls='ls -hF --color=tty'  # classify files in colour
alias ll='ls -lah'  # long list
alias la='ls -A'  # all but . and ..
alias sl="ls --color" # for typos :)
alias lf="ls -f" # fast ls

eval "`dircolors ~/.dircolors`"

#
# history control
# 

# don't put duplicate lines in the history. See bash(1) for more options
HISTCONTROL=ignoredups:ignorespace
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

if [ -z "$USER" ]; then
    export USER=`whoami`  # export user on qrsh sessions
fi

# Store all history with times and directories
function store_history () {
    # non-gawk version: echo -e `date`"\t$PWD\t"`history 1 | awk '{ printf $2} '`
    history 1 | awk '($2 !~ "^[mr]?cd[0-9a-z]?$") {$1="_T="strftime("%Y%m%d_%H:%M:%S_") PROCINFO["ppid"] "_PWD="  ENVIRON["PWD"] "\t"; $2=gensub("^_T=[-_0-9:]*[ \t]* *", "", 1, $2); $2=gensub("^_P=[^ \t]* *", "", 1, $2); print;}' >> ~/.history-all-$USER
}
export PROMPT_COMMAND="store_history"

# Grep history
function dhist (){
    DIR=`pwd`
    command grep "_PWD=$DIR"$'\t'".*$@" ~/.history-all-$USER | tail -n 30
}

function hist (){    
    if [ "$#" -eq 0 ]; then
        tail -n 30 ~/.history-all-$USER
    else
        command grep "$@" ~/.history-all-$USER | tail -n 30
    fi
}

#
# ssh controls
#

function start_ssh_agent () {
    # SSH agent
    AGENT_SIGFILE=~/.ssh/running-agent_`hostname -s`
    LAST_AGENT=`cat $AGENT_SIGFILE  2> /dev/null | grep 'AGENT_PID' | sed 's/.*=\([0-9]*\);.*/\1/'`
    if [ -z "$LAST_AGENT" ]; then
        return # do not start agent in weird places (kirsch, lrc, sol11 is enough)
    fi
    #echo 'Last SSH agent PID: ' $LAST_AGENT
    ps ax | grep "^ *$LAST_AGENT " > /dev/null || ssh-agent > $AGENT_SIGFILE
    #echo 'Current SSH agent PID: ' `cat $AGENT_SIGFILE 2> /dev/null | grep 'AGENT_PID' | sed 's/.*=\([0-9]*\);.*/\1/'`
    . $AGENT_SIGFILE > /dev/null
    alias ssh="ssh -XYC" # Force X-forwarding (+alias adding the key to agent)
    ssh-add -l >/dev/null || { alias ssh='ssh-add -l >/dev/null || ssh-add && alias ssh="ssh -XYC"; ssh -XYC'; }
}

# On TTYs only:
if ( tty -s ); then
    # Greeting
    echo -e 'Hi, this is\033[0;'${COLOR}'m' `hostname` '\033[0m' 1>&2
    # start the SSH agent
    start_ssh_agent
fi



# Fixing terminal
#

if [[ -n "$TERMINATOR_UUID" && "$TERM" != "screen-256color" ]]; then # we're running inside Terminator, we know it can do 256 colors
    export TERM=xterm-256color
fi
if [ '(' "$TERM" = "dumb" ')' -o '(' "$TERM" = "linux" ')' ]; then # force xterm on qrsh sessions
    export TERM=xterm-256color
fi


# up-dir function
#
up_dir(){
    levels=$1
    if [ -z "$levels" ]; then
        levels=1
    fi
    target=".."
    for i in `seq 2 $levels`; do
        target="$target/.."
    done
    cd $target
}

#
# aliases
#

alias vi="vim"
alias git-log-pretty="git log --pretty=format:\"%h - %an, %ar : %s\" -9"
alias tmuxl="tmux list-sessions"
alias tmuxa="tmux attach -t"
alias ..='up_dir'
alias quit='exit'
alias duh='du -h --max-depth=1'
alias fullpath='find `pwd` -name '
function clearlatex (){ rm "$1".{aux,bbl,blg,fdb_latexmk,fls,log,out,synctex.gz}; }
alias lualatexmk='latexmk -pdflatex="lualatex %O %S" -pdf -interaction=nonstopmode -synctex=1 -pvc'
alias xelatexmk='latexmk -pdflatex="xelatex %O %S" -pdf -interaction=nonstopmode -synctex=1 -pvc'
alias pdflatexmk='latexmk -pdflatex="pdflatex %O %S" -pdf -interaction=nonstopmode -synctex=1 -pvc'

#
# variables
#

export EDITOR="vim"
export PATH="/home/$USER/bin:/home/$USER/.local/bin:$PATH"

LOCAL_PREFIX=/home/$USER/.local
export PYTHONUSERBASE=$LOCAL_PREFIX
export PATH="$PYTHONUSERBASE/bin:$PATH"

export PERL5LIB="/home/$USER/.local/lib/perl5"
export PERLLIB="$PERL5LIB"
export PERL_MB_OPT='--install_base "/home/$USER/.local"'
export PERL_LOCAL_LIB_ROOT=/home/$USER/.local
export PERL_MM_OPT=INSTALL_BASE=/home/$USER/.local

export R_LIBS_USER=/home/$USER/.R/
