#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export PATH=$HOME/bin:$HOME/.local/bin:$PATH
export MANPATH=$MANPATH:$HOME/share/man
export TERM=xterm-256color
export EDITOR=vim
export VISUAL=$EDITOR
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [[ -x /usr/libexec/java_home ]]; then
    export JAVA_HOME=`/usr/libexec/java_home`
fi

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh

# Install local environment if found in home directory.
[ -s "$HOME/.localenv" ] && source $HOME/.localenv
