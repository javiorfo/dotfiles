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

# EXA
export EXA_COLORS="di=1;38;5;242:fi=38;5;250:ex=38;5;228:ln=1;38;5;245"

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
# alias ls='ls --color=auto'
alias ls='exa --icons'
alias grep='grep --color=auto'

# Prompt
PROMPT="%F{240}╭─%{$reset_color%} %B%F{245}%n %~%{$reset_color%}%b %F{15}\$(git_branch)%{$reset_color%}
%F{240}╰─%{$reset_color%} "
# PROMPT=" %B%F{245}%~%{$reset_color%}%b %F{15}\$(git_branch)%{$reset_color%}%F{245}%{$reset_color%} "
