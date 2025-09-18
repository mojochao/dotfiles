# Define a utility function to test if some executable file is in PATH.
is_bin_in_path () {
  if [[ -n $ZSH_VERSION ]]; then
    builtin whence -p "$1" &> /dev/null
  else  # bash:
    builtin type -P "$1" &> /dev/null
  fi
  [[ $? -ne 0 ]] && return 1
  if [[ $# -gt 1 ]]; then
    shift  # We've just checked the first one
    is_bin_in_path "$@"
  fi
}

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

# # Set name of the theme to load. Optionally, if you set this to "random"
# # it'll load a random theme each time that oh-my-zsh is loaded.
# # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# # lambdork=realpath $ZSH/themes/lambdork.zsh-theme
# if [[ -f $ZSH/themes/lambdork.zsh-theme ]]; then
#     ZSH_THEME="lambdork"
# else
#     ZSH_THEME="simple"
# fi

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
  git
  helm
  kubectl
  terraform
#  zsh-autopair
#  zsh-autosuggestions
#  zsh-history-substring-search
#  zsh-syntax-highlighting
)

# # Disable aws plugin display of aws profile info in RPROMPT.
# export SHOW_AWS_PROMPT=false

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
# Configure brew package manager
# ---------------------------------------------------------

if [[ "$OSTYPE" == darwin* ]]; then
    HOMEBREW_ROOT=/opt/homebrew
elif [[ "$OSTYPE" == linux* ]]; then
    HOMEBREW_ROOT=/home/linuxbrew/.linuxbrew
fi
export PATH=$HOMEBREW_ROOT/sbin:$HOMEBREW_ROOT/bin:$PATH

# ---------------------------------------------------------
# Configure asdf package manager
# ---------------------------------------------------------

if [[ -f $HOME/.asdf/asdf.sh ]]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
  export PATH=$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH
fi

# ---------------------------------------------------------
# Configure direnv (https://direnv.net/)
# ---------------------------------------------------------

eval "$(direnv hook zsh)"

# ---------------------------------------------------------
# Configure starship (https://starship.rs/)
# ---------------------------------------------------------

eval "$(starship init zsh)"

# ---------------------------------------------------------
# Configure zoxide (https://github.com/ajeetdsouza/zoxide)
# ---------------------------------------------------------

eval "$(zoxide init zsh)"

# ---------------------------------------------------------
# Configure diff-so-fancy
# https://github.com/so-fancy/diff-so-fancy
# ---------------------------------------------------------

if [[ -d $HOME/src/github.com/so-fancy/diff-so-fancy ]]; then
  export PATH=$PATH:$HOME/src/github.com/so-fancy/diff-so-fancy
fi

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

# https://github.com/sharkdp/fd
[[ -f $(which fd) ]] && export FZF_DEFAULT_COMMAND='fd --type f'

# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"
[[ -f ~/.less_termcap ]] && . ~/.less_termcap

# Shell function to repeat a command a number of times.
dotimes () {
  seq 1 $1 | xargs -I{} "${@:2}"
}

# ---------------------------------------------------------
# Docker tooling
# ---------------------------------------------------------

[[ -d $HOME/.docker/bin ]] && export PATH=$PATH:$HOME/.docker/bin

# ---------------------------------------------------------
# Kubernetes tooling
# ---------------------------------------------------------

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

if [[ -d $HOME/src/github.com/WoozyMasta/kube-dump ]]; then
  export PATH=$PATH:$HOME/src/github.com/WoozyMasta/kube-dump
fi

# https://github.com/danielfoehrKn/kubeswitch
source <(switcher init zsh)

# Add kimages utility function to list all images in all pods.
kimages () {
    kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" |\
	tr -s '[[:space:]]' '\n' |\
	sort |\
	uniq -c
}

# Add kneato utility function to dump neat object state.
kneato () {
    local namespace_args=()
    local resource_args=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -n|--namespace)
                if [[ -n "$2" ]]; then
                    namespace_args+=("$1" "$2")
                    shift 2
                else
                    echo "Error: Namespace name is missing after $1"
                    return 1
                fi
                ;;
            *)
                resource_args+=("$1")
                shift
                ;;
        esac
    done

    if [ ${#resource_args[@]} -eq 1 ]; then
        echo kubectl get "${resource_args[0]}" "${namespace_args[@]}" -o yaml #| kubectl neat
    elif [ ${#resource_args[@]} -eq 2 ]; then
        echo kubectl get "${resource_args[0]}" "${resource_args[1]}" "${namespace_args[@]}" -o yaml #| kubectl neat
    else
        echo "Usage: kneato [-n NAMESPACE|--namespace NAMESPACE] KIND/NAME | KIND NAME"
        return 1
    fi
}

# kneato () {
#     # Support resource id by 'deploy/my-deploy' form
#     if [ $# -eq 1 ]; then
#         kubectl get $1  -o yaml | kubectl neat
#     # Support resource id by 'deploy my-deploy' form
#     elif [ $# -eq 2 ]; then
#         kubectl get $1 $2 -o yaml | kubectl neat
#     else
#         echo "Usage: kneato KIND/NAME | KIND NAME"
#     fi
# }

# Add kgetall utility function to dump all resources in a namespace.
function kgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl -n ${1} get --ignore-not-found ${i}
  done
}

# ---------------------------------------------------------
# Golang development
# ---------------------------------------------------------

export PATH=$HOME/go/bin:$PATH

# ---------------------------------------------------------
# Python development
# ---------------------------------------------------------

[[ -d $HOME/.asdf/installs/python/3.10.5/bin ]] && export PATH=$PATH:$HOME/.asdf/installs/python/3.10.5/bin
if [[ "$OSTYPE" == darwin* ]]; then
  [[ -d $HOME/Library/Python/3.9/bin ]] && export PATH=$PATH:$HOME/Library/Python/3.9/bin
  [[ -d $HOME/Library/Python/3.8/bin ]] && export PATH=$PATH:$HOME/Library/Python/3.8/bin
  [[ -d $HOME/Library/Python/3.7/bin ]] && export PATH=$PATH:$HOME/Library/Python/3.7/bin
fi

# ---------------------------------------------------------
# Rust development
# ---------------------------------------------------------

[[ -d $HOME/.cargo/bin ]] && export PATH=$PATH:$HOME/.cargo/bin

# ---------------------------------------------------------
# Codeium
# ---------------------------------------------------------

export PATH="/Users/agooch/.codeium/windsurf/bin:$PATH"

# ---------------------------------------------------------
# Source any existing local environment
# ---------------------------------------------------------

[[ -s "$HOME/.aliases" ]]  && source $HOME/.aliases
[[ -s "$HOME/.kubectl_aliases" ]]  && source $HOME/.kubectl_aliases
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
