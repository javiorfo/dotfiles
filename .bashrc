# ENV
# Java
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
# Maven
export M2_HOME=/opt/maven
# Go
export GOPATH=$HOME/Documentos/go
# Path
export PATH=$PATH:$JAVA_HOME/bin:$M2_HOME/bin:$GOPATH/bin
export GITHUB=https://token@github.com/charkuils/

# Git
function git_branch(){                                                                                                 
    ref=$(git symbolic-ref --short --quiet HEAD 2>/dev/null)
    if [ -n "${ref}" ]; then
        echo "󰊢 ""$ref"""
    fi
}

function gpush() {
    git push $GITHUB/"$1"
}

function gpull() {
    git pull $GITHUB/"$1"
}

# Alias
# alias ls='ls --color=auto'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m $1'
alias grep='grep --color=auto'
