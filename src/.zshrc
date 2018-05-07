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

# See https://kubernetes.io/docs/reference/generated/kubectl/kubectl/ for more info.
command -v kubectl > /dev/null 2>&1 && source <(kubectl completion zsh)

# Install minikube completions if available.
# See https://github.com/kubernetes/minikube for more info.
command -v minikube > /dev/null 2>&1 && source <(minikube completion zsh)

# Install virtualenvwrapper commands if available.
# See https://virtualenvwrapper.readthedocs.io/en/latest for more info.
[ -s /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper_lazy.sh

# Install shared aliases if found in home directory.
[ -s "$HOME/.aliases" ] && source $HOME/.aliases

# Install local environment if found in home directory.
[ -s "$HOME/.localrc" ] && source $HOME/.localrc

if [[ "$OSTYPE" == darwin* ]]; then
    EMACS_APP_BIN=/Applications/Emacs.app/Contents/MacOS/bin
    PYTHON36_USER_DIR=~/Library/Python/3.6
    export PATH=$EMACS_APP_BIN:$PYTHON36_USER_DIR/bin:$PATH
    export ICLOUD_DIR=~/Library/Mobile\ Documents/com~apple~CloudDocs
fi
