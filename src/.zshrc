# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH
export MANPATH=$MANPATH:$HOME/share/man:/usr/local/man
export EDITOR=vim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# https://github.com/ohmyzsh/ohmyzsh/issues/8682
if [[ -n "$INSIDE_EMACS" ]]; then
   # export TERM=
else
  export TERM=xterm-256color
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# lambdork=realpath $ZSH/themes/lambdork.zsh-theme
if [[ -f $ZSH/themes/lambdork.zsh-theme ]]; then
    ZSH_THEME="lambdork"
else
    ZSH_THEME="simple"
fi

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  aws
  kube-ps1
)

# Disable aws plugin display of aws profile info in RPROMPT.
export SHOW_AWS_PROMPT=false

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ---------------------------------------------------------
# Configure mcfly for ctrl-r intelligence
# ---------------------------------------------------------


which mcfly >> /dev/null 2>&1
if [[ $? -eq 0 ]]; then
  eval "$(mcfly init zsh)"
fi

# ---------------------------------------------------------
# Configure asdf package manager
# ---------------------------------------------------------

if [[ -f $HOME/.asdf/asdf.sh ]]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
fi

# ---------------------------------------------------------
# Configure brew package manager
# ---------------------------------------------------------

[[ -f /home/linuxbrew/.linuxbrew/bin/brew ]] && export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

# ---------------------------------------------------------
# Configure dockerized
# https://github.com/datastack-net/dockerized
# ---------------------------------------------------------

[[ -d $HOME/.dockerized/bin ]] && export PATH=$PATH:$HOME/.dockerized/bin

# ---------------------------------------------------------
# Configure diff-so-fancy
# https://github.com/so-fancy/diff-so-fancy
# ---------------------------------------------------------

[[ -d $HOME/src/github.com/so-fancy/diff-so-fancy ]] && export PATH=$PATH:$HOME/src/github.com/so-fancy/diff-so-fancy

# ---------------------------------------------------------
# Configure forgit
# https://github.com/wfxr/forgit
# ---------------------------------------------------------

FORGIT_PLUGIN="$HOME/src/github.com/wfxr/forgit/forgit.plugin.zsh"
[[ -s $FORGIT_PLUGIN ]]  && source $FORGIT_PLUGIN

# ---------------------------------------------------------
# Configure macOS-specific things
# ---------------------------------------------------------

if [[ "$OSTYPE" == darwin* ]]; then
  # Use emacs binary from macos app.
  EMACS_APP_BIN=/Applications/Emacs.app/Contents/MacOS/bin
  export PATH=$EMACS_APP_BIN:$PATH
  # Add iCloud directory root env var.
  export ICLOUD_DIR=~/Library/Mobile\ Documents/com~apple~CloudDocs
  # Configure iterm2 integration.
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# ---------------------------------------------------------
# Configure general productivity enhancers
# ---------------------------------------------------------

which fd >> /dev/null 2>&1
if [[ $? -eq 0 ]]; then
  export FZF_DEFAULT_COMMAND='fd --type f'
fi

# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"
[[ -f ~/.less_termcap ]] && . ~/.less_termcap

# Shell function to repeat a command a number of times.
dotimes () {
  seq 1 $1 | xargs -I{} "${@:2}"
}

# ---------------------------------------------------------
# Kafka tooling
# ---------------------------------------------------------

if [[ -d "$HOMEBREW_ROOT/Cellar/kafka/2.8.0" ]]; then
  export KAFKA_HOME=/usr/local/Cellar/kafka/2.8.0
  export PATH=$PATH:$KAFKA_HOME/bin
fi

# ---------------------------------------------------------
# Kubernetes tooling
# ---------------------------------------------------------

# Configure kubectl info in prompt. Ensure kube-ps is installed.
# On mac, install with `brew install kube-ps1` command.
# See https://github.com/jonmosco/kube-ps1 for config details.
if [[ -f "/usr/local/opt/kube-ps1/share/kube-ps1.sh" ]]; then
  source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
  export KUBE_PS1_CTX_COLOR=blue
  export KUBE_PS1_NS_COLOR=magenta
  export KUBE_PS1_PREFIX=''
  export KUBE_PS1_SUFFIX=''
  export KUBE_PS1_SEPARATOR=''
fi

 # Add krew to path.
if [[ -d $HOME/.krew ]]; then
  export KREW_ROOT=~/.krew
  export PATH=$PATH:$KREW_ROOT/bin
fi

if [[ -d $HOME/src/github.com/WoozyMasta/kube-dump ]]; then
  export PATH=$PATH:$HOME/src/github.com/WoozyMasta/kube-dump
fi

# Add kneato utility function to dump neat object state.
kneato () {
  kubectl get $1 $2 -o yaml | kubectl neat
}

function kubectlgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl -n ${1} get --ignore-not-found ${i}
  done
}

# ---------------------------------------------------------
# Golang development
# ---------------------------------------------------------

[[ -d $HOME/go/bin ]] && export PATH=$PATH:$HOME/go/bin

# ---------------------------------------------------------
# Python development
# ---------------------------------------------------------

[[ -d $HOME/Library/Python/3.7/bin ]] && export PATH=$PATH:$HOME/Library/Python/3.7/bin
[[ -d $HOME/Library/Python/3.8/bin ]] && export PATH=$PATH:$HOME/Library/Python/3.8/bin
[[ -d $HOME/Library/Python/3.9/bin ]] && export PATH=$PATH:$HOME/Library/Python/3.9/bin

# ---------------------------------------------------------
# Rust development
# ---------------------------------------------------------

[[ -d $HOME/.cargo/bin ]] && export PATH=$PATH:$HOME/.cargo/bin

# ---------------------------------------------------------
# Source any existing local environment
# ---------------------------------------------------------

[[ -s "$HOME/.aliases" ]]  && source $HOME/.aliases
[[ -s "$HOME/.localenv" ]] && source $HOME/.localenv
[[ -s "$HOME/.localrc" ]]  && source $HOME/.localrc

# ---------------------------------------------------------
# Manage bookmarks
# ---------------------------------------------------------

# This uses the static named directories feature of zsh.
# Such directories are declared with `hash -d name=directory`.
# Both prompt expansion and completion know how to handle
# them. We populate the hash with directories.
#
# With autocd, you can just type `~-bookmark`. Since this can
# be cumbersome to type, you can also type `@@` and this will
# be turned into `~-` by ZLE.
#
# See https://github.com/vincentbernat/zshrc/blob/master/rc/bookmarks.zsh
# for details.
autoload -U is-at-least

is-at-least 4.3.12 && () {
    MARKPATH=$ZSH/run/marks

    # Add some static entries
    hash -d log=/var/log
    hash -d doc=/usr/share/doc

    # Populate the hash
    for link ($MARKPATH/*(N@)) {
        hash -d -- -${link:t}=${link:A}
    }

    vbe-insert-bookmark() {
        emulate -L zsh
        LBUFFER=${LBUFFER}"~-"
    }
    zle -N vbe-insert-bookmark
    bindkey '@@' vbe-insert-bookmark

    # Manage bookmarks
    bookmark() {
        [[ -d $MARKPATH ]] || mkdir -p $MARKPATH
        if (( $# == 0 )); then
            # When no arguments are provided, just display existing
            # bookmarks
            for link in $MARKPATH/*(N@); do
                local markname="$fg[green]${link:t}$reset_color"
                local markpath="$fg[blue]${link:A}$reset_color"
                printf "%-30s -> %s\n" $markname $markpath
            done
        else
            # Otherwise, we may want to add a bookmark or delete an
            # existing one.
            local -a delete
            zparseopts -D d=delete
            if (( $+delete[1] )); then
                # With `-d`, we delete an existing bookmark
                command rm $MARKPATH/$1
            else
                # Otherwise, add a bookmark to the current
                # directory. The first argument is the bookmark
                # name. `.` is special and means the bookmark should
                # be named after the current directory.
                local name=$1
                [[ $name == "." ]] && name=${PWD:t}
                ln -s $PWD $MARKPATH/$name
                hash -d -- -${name}=${PWD}
            fi
        fi
    }
}

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
