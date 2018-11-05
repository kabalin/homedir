# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Hopefully fix java issues with awesome
# http://extramem.blogspot.com/2009/04/java-misbehaving-in-awesome-window.html
export AWT_TOOLKIT=MToolkit

############################################################################
# History management
############################################################################
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
# show when command was run
export HISTTIMEFORMAT='%F %T '
# Store 999 entries
export HISTSIZE=999
# Make bash append rather than overwrite history on disk
shopt -s histappend

############################################################################
# Window size
############################################################################
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

############################################################################
# More pleasing less
############################################################################
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

############################################################################
# Initial PS1 building
############################################################################
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

############################################################################
# xterm title
############################################################################
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

############################################################################
# Bash Completion
############################################################################
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -f /opt/csw/etc/bash_completion ]; then
    . /opt/csw/etc/bash_completion
fi
if [ -f /etc/opt/csw/bash_completion ]; then
    . /etc/opt/csw/bash_completion
fi

############################################################################
# git prompt settings
############################################################################
default_prompt="\! \u@\h:\w> "

function get_prompt_command ()
{
    local RED='\[\e[0;31m\]'
    local YELLOW='\[\e[0;33m\]'
    local GREEN='\[\e[0;32m\]'
    local NOCOL='\[\e[0m\]'

    git_branch=$( parse_git_branch )

    if [ -n "$git_branch" ]; then

        # Set the branch name to green if it's clean, red otherwise.
        git_clean_p
        if [[ $? == 0 ]]; then
            dirstate='clean'
            if [[ "$git_branch" == "master" ]]; then
                GITCOLOR=$YELLOW
            else
                GITCOLOR=$GREEN
            fi
        else
            dirstate='dirty'
            GITCOLOR=$RED
        fi

        PS1="\! $(path_within_git_repo):$GITCOLOR$git_branch$NOCOL> "
        echo -ne "]2;${USER}@${HOSTNAME} $git_branch($dirstate) $(path_within_git_repo)"
    else
        PS1="$NOCOL$default_prompt"
        echo -ne "]2;${USER}@${HOSTNAME} `pwd`"
    fi
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# This will fail if your directory name contains a '!', but then you
# deserve to be flogged anyway.
function path_within_git_repo ()
{
    repo_base=$( git rev-parse --git-dir )

    if [ $( expr "$repo_base" : '/' ) -lt 1 ]
    then
        # We're in the base repo directory, so git-rev-parse has just
        # given us '.git'
        repo_base="$(pwd)/$repo_base"
    fi

    repo_parent=$( expr "$repo_base" : '\(.*\)/.*/\.git$' )

    pwd | sed -e "s!$repo_parent/!!"
}

# Exit value of 0 if the repo is clean, 1 otherwise
function git_clean_p ()
{
    git status | egrep 'working (directory|tree) clean' 2>&1 > /dev/null
}

PROMPT_COMMAND='get_prompt_command'
PS2='> '

############################################################################
# Useful general aliases
############################################################################

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias cdg='cd $HOME/git'
alias ma='git checkout master'
alias cerebro='cd $HOME/git/cerebro'
alias kcol='cd $HOME/git/kcol'
alias rectags="find . -name .ctags.local -type f -print0 | xargs --null -n 1 -IX sh -c 'cd \`dirname \"X\"\` && ctags -R'"

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

############################################################################
# Include $HOME in $PATH and $MANPATH
############################################################################
PATH=$PATH:$HOME/bin:$HOME/local/bin
MANPATH=$MANPATH:$HOME/local/share/man

############################################################################
# Operating System specific settings
############################################################################
case $(uname) in
Linux)
    # We almost certainly have a GNU userland, so set up a few aliases
    # specific to the GNU tools
    alias ls='ls -F --color'
    alias ll='ls -lF --color'
    ;;
*)
    ;;
esac

############################################################################
# Yet more colour...
############################################################################
# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

############################################################################
# Actually set most of our environment variables
############################################################################
export EDITOR=vim
export EMAIL='ruslan.kabalin@gmail.com' # Used by debchange
export PATH MANPATH TERM
# Debian package management variables
export DEBEMAIL="ruslan.kabalin@gmail.com"
export DEBFULLNAME="Ruslan Kabalin"

############################################################################
# Include any other bash_includes if they exist
############################################################################
if [ -f $HOME/.bash/bash_includes ]; then
    source $HOME/.bash/bash_includes
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
