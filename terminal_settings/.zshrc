# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Mac OS
if [[ "$OSTYPE" == darwin* ]]; then
    # Init Homebrew
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    export PATH="$PATH:$HOME/.local/bin"

    ip=$(ifconfig en0 2>/dev/null | grep 'inet ' | awk '{print $2}')
    [ -n "$ip" ] && echo "IP: $ip"

    export PATH="/usr/sbin:$PATH"
    export PATH="/sbin:$PATH"

    # pyenv (brew install pyenv pyenv-virtualenv)
    export PATH="$HOME/.pyenv/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
    fi

    # Ruby (chruby for jekyll)
    # https://jekyllrb.com/docs/installation/macos/
    if [ -f "$(brew --prefix 2>/dev/null)/opt/chruby/share/chruby/chruby.sh" ]; then
        source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
        source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
        # chruby ruby-3.3.5
    fi

    # Java: uncomment and set your preferred JDK
    # export JAVA_HOME=$(/usr/libexec/java_home -v 17)
    # export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home"
    # export PATH=$JAVA_HOME/bin:$PATH

    # Flutter
    export PATH="$PATH":"$HOME/.pub-cache/bin"

# Linux (Ubuntu / WSL2)
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    ip=$(hostname -I 2>/dev/null | awk '{print $1}')
    [ -n "$ip" ] && echo "IP: $ip"

    export PATH="$PATH:$HOME/.local/bin"

    # pyenv
    export PATH="$HOME/.pyenv/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
    fi

    # Linuxbrew (optional)
    # if [ -d "$HOME/.linuxbrew" ]; then
    #     eval $($HOME/.linuxbrew/bin/brew shellenv)
    # fi

# Git Bash (Windows)
elif [[ "$OSTYPE" == "msys" ]]; then
    ip=$(ipconfig | grep IPv4 | sed s"/.*: //g" | awk 1 ORS=' | ' | sed s"/ | $//g")
    echo "$ip"

elif [[ "$OSTYPE" == "linux-android" ]]; then
    # Android / Termux
    ip=$(hostname -I 2>/dev/null | awk '{print $1}')
    [ -n "$ip" ] && echo "$ip"

    export ANDROID_AVD_HOME=$HOME/.android/avd/

else
    echo "!!! WARNING !!!"
    echo "This is an unexpected situation! ($OSTYPE / $(hostname))"
fi


##############################################################################

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $HOME/.oh-my-zsh/plugins/*
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# export PAGER="most" //color manual
export PAGER="less"

# Disable default aliases made by oh-my-zsh.sh
unalias -a

source $HOME/.my_aliases.sh


# delete duplicated PATH
PATH=$(echo $PATH | awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}' | sed 's/:$//')

# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh


# Python virtual environment auto-activation
if [ -d "$HOME/.pyenv/versions/_venv_py" ]; then
    source $HOME/.pyenv/versions/_venv_py/bin/activate
    echo "Python venv activated: $(basename $VIRTUAL_ENV)"
elif [ -d "$HOME/_ALL_CODES/_venv_py" ]; then
    source $HOME/_ALL_CODES/_venv_py/bin/activate
    echo "Python venv activated: $(basename $VIRTUAL_ENV)"
fi


echo "OSTYPE: $OSTYPE"
echo "NAME: $(hostname)"

# GPG signing
# https://github.com/romkatv/powerlevel10k/issues/524
export GPG_TTY=$TTY

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
