# JAVA
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export JAVA_WORKSPACE=$HOME/dev/java
# export JAVA_HOME=/usr/lib/jvm/java-21-graalvm-ee
export M2_HOME=/opt/maven

# GO
export GOPATH=$HOME/dev/go
export GOTELEMETRY=off

# PATH
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

# COLORS
export LS_COLORS="fi=37:di=01;90:ex=33:ln=37:or=37:mi=00:mh=37\
:pi=37:so=37;30:do=37:bd=37:cd=37:su=37:sg=37:ca=37:tw=37:ow=37:st=37"

# LANG
export LANG=en

# EDITOR
export SUDO_EDITOR="nvim"
export EDITOR="nvim"
export VISUAL="nvim"

# GIT
export GITHUB=https://token@github.com/javiorfo

function git_branch(){
    ref=$(git symbolic-ref --short --quiet HEAD 2>/dev/null)
    if [ -n "${ref}" ]; then
        echo "󰊢  ""$ref """
    fi
}

function gpush() {
    git push $GITHUB/"$1"
}

function gpull() {
    git pull $GITHUB/"$1"
}

# SETTINGS
set -o vi

# ALIASES
alias ls='ls --color=auto --group-directories-first'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m $1'
alias grep='grep --color=auto'
alias trans='trans -from en -to es $1'

# PROMPT
PS1="\[\033[34m\]\[\033[1;97m\]  \[\e[0;90m\] \w \[\e[1;90m\]\$(git_branch)󰁕\[\e[0;37m\] "
