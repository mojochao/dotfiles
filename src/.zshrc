# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.cargo/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/go/libexec/bin:$PATH
export MANPATH=$MANPATH:$HOME/share/man:/usr/local/man
export EDITOR=vim
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="lambdork"

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
  docker
  docker-compose
  docker-machine
  git
  helm
  kubectl
  minikube
  poetry
  terraform
  tmux
)

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

# Configure kubectl info in prompt. Ensure kube-ps is installed.
# On mac, install with `brew install kube-ps1` command.
# See https://github.com/jonmosco/kube-ps1 for config details.
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
export KUBE_PS1_CTX_COLOR=blue
export KUBE_PS1_NS_COLOR=magenta

# Install virtualenvwrapper commands if available.
# See https://virtualenvwrapper.readthedocs.io/en/latest for more info.
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
[ -s /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper_lazy.sh

# Configure poetry
export PATH=$PATH:~/.poetry/bin

# Configure fzf default file finder.
export FZF_DEFAULT_COMMAND='fd --type f'

# Install local environment if found in home directory.
[ -s "$HOME/.aliases" ] && source $HOME/.aliases
[ -s "$HOME/.localenv" ] && source $HOME/.localenv
[ -s "$HOME/.localrc" ] && source $HOME/.localrc

if [[ "$OSTYPE" == darwin* ]]; then
    EMACS_APP_BIN=/Applications/Emacs.app/Contents/MacOS/bin
    PYTHON37_USER_DIR=~/Library/Python/3.7
    export PATH=$EMACS_APP_BIN:$PYTHON37_USER_DIR/bin:$PATH
    export ICLOUD_DIR=~/Library/Mobile\ Documents/com~apple~CloudDocs
fi

# Setup erlang development
export MANPATH=$MANPATH:/usr/local/opt/erlang/lib/erlang/man

# Setup golang development
export PATH=$PATH:~/go/bin

# Install Google Cloud SDK.
# The next line updates PATH for the Google Cloud SDK.
export GOOGLE_CLOUD_SDK_DIR=$HOME/sdk/google-cloud-sdk
if [ -f $GOOGLE_CLOUD_SDK_DIR/path.zsh.inc ]; then source $GOOGLE_CLOUD_SDK_DIR/path.zsh.inc; fi
# The next line enables shell command completion for gcloud.
if [ -f $GOOGLE_CLOUD_SDK_DIR/completion.zsh.inc ]; then source $GOOGLE_CLOUD_SDK_DIR/completion.zsh.inc; fi

# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"
[[ -f ~/.less_termcap ]] && . ~/.less_termcap

# Shell function to repeat a command a number of times.
dotimes () {
    seq 1 $1 | xargs -I{} "${@:2}"
}

# https://github.com/vincentbernat/zshrc/blob/master/rc/bookmarks.zsh
#
# Handle bookmarks. This uses the static named directories feature of
# zsh. Such directories are declared with `hash -d name=directory`.
# Both prompt expansion and completion know how to handle them. We
# populate the hash with directories.
#
# With autocd, you can just type `~-bookmark`. Since this can be
# cumbersome to type, you can also type `@@` and this will be turned
# into `~-` by ZLE.
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

export KUBE_EDITOR="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code -w"

# Make gems available in path
GEM_HOME=$HOME/gems
RUBY_HOME=/usr/local/opt/ruby
export PATH=$GEM_HOME/bin:$RUBY_HOME/bin:$PATH
#GEM_BIN=~/.gem/ruby/2.6.0/bin:/usr/local/lib/ruby/gems/2.6.0/bin
#export PATH=$GEM_BIN:$PATH
eval "$(rbenv init -)"

# xdg-open without spam
xo() {
    if [[ "$OSTYPE" == darwin* ]]; then
        open $1 &>/dev/null
    elif [[ "$OSTYPE" == linux* ]]; then
        xdg-open $1 &>/dev/null
    fi
}

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
