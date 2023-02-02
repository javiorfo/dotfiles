# Env
# Java
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
# Maven
export M2_HOME=/opt/maven
# Path
export PATH=$PATH:$JAVA_HOME/bin:$M2_HOME/bin

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# History
export HISTFILE="$HOME/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000
export KEYTIMEOUT=1
setopt HIST_SAVE_NO_DUPS

# Git
function git_branch(){                                                                                                 
    ref=$(git symbolic-ref --short --quiet HEAD 2>/dev/null)
    if [ -n "${ref}" ]; then
        echo " ""$ref"""
    fi
}
setopt PROMPT_SUBST

# Autoloads
# Colors
autoload -U colors && colors
# Autocomplete
autoload -U compinit; compinit
#
# autoload -Uz vcs_info

# Vi mode
bindkey -v

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt
PROMPT="%F{240}╭─%{$reset_color%} %B%F{245}%n %~%{$reset_color%}%b %B%F{15}\$(git_branch)%{$reset_color%}%b
%F{240}╰─%{$reset_color%} "