#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

export PATH=$HOME/bin:$HOME/.local/bin:$PATH
export MANPATH=$MANPATH:$HOME/share/man
export TERM=xterm-256color
export EDITOR=vim
export VISUAL=$EDITOR
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export SDK_DIR=$HOME/sdk
export REPOS_DIR=$HOME/repos

if [[ "$OSTYPE" == darwin* ]]; then
    EMACS_APP_BIN=/Applications/Emacs.app/Contents/MacOS/bin
    PYTHON36_USER_DIR=~/Library/Python/3.6
    export PATH=$EMACS_APP_BIN:$PYTHON36_USER_DIR/bin:$PATH
    export ICLOUD_DIR=~/Library/Mobile\ Documents/com~apple~CloudDocs
fi

if [[ -x /usr/libexec/java_home ]]; then
    export JAVA_HOME=`/usr/libexec/java_home`
fi

# Install asdf command if installed.
# See https://github.com/asdf-vm/asdf for more info.
[ -s "$HOME/.asdf/asdf.sh" ] && source $HOME/.asdf/asdf.sh
[ -s "$HOME/.asdf/completions/asdf.bash" ] && source $HOME/.asdf/completions/asdf.bash

# Install nvm command if installed.
# See https://github.com/creationix/nvm for more info.
# Currently, asdf isn't working with nodejs, so nvm it is.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source $NVM_DIR/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && source $NVM_DIR/bash_completion

# Install kubectl completions if installed.
# See https://kubernetes.io/docs/reference/generated/kubectl/kubectl/ for more info.
command -v kubectl > /dev/null 2>&1 && source <(kubectl completion zsh)

# Install minikube completions if installed.
# See https://github.com/kubernetes/minikube for more info.
command -v minikube > /dev/null 2>&1 && source <(minikube completion zsh)

# Add virtualenvwrapper commands if installed.
# See https://virtualenvwrapper.readthedocs.io/en/latest for more info.
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
[ -s /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper_lazy.sh

# Install aliases if found in home directory.
[ -s "$HOME/.aliases" ] && source $HOME/.aliases

# Install private environment if found in home directory.
[ -s "$HOME/.private" ] && source $HOME/.private
