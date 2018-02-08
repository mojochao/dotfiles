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

# Install asdf command if exists.  See https://github.com/asdf-vm/asdf for more info.
[ -s "$HOME/.asdf/asdf.sh" ] && source $HOME/.asdf/asdf.sh
[ -s "$HOME/.asdf/completions/asdf.bash" ] && source $HOME/.asdf/completions/asdf.bash

# Install kubectl completions if exists.
command -v kubectl > /dev/null 2>&1 && source <(kubectl completion zsh)

# Add virtualenvwrapper commands if exists.
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
[ -s /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# Install aliases.
[ -s "$HOME/.aliases" ] && source $HOME/.aliases

# Install private environment if found in home directory.
[ -s "$HOME/.private" ] && source $HOME/.private
