# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sorin"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
plugins=(git archlinux taskwarrior autojump vi-mode zsh-syntax-highlighting)

# User configuration

export PATH=$HOME/scripts:$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=es_ES.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='emacs'
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

# import private settings if file exists
[ -f ~/.zshrc-private ] && source ~/.zshrc-private

alias cfg-zsh="$EDITOR ~/.zshrc"
alias cfg-vim="$EDITOR ~/.vimrc"
alias cfg-fish="$EDITOR ~/.config/fish/config.fish"
alias cfg-i3="$EDITOR ~/.config/i3/config"
alias cfg-ranger="$EDITOR ~/.config/ranger/rc.conf"
alias cfg-xresources="$EDITOR ~/.Xresources && xrdb ~/.Xresources"
alias cfg-emacs="$EDITOR ~/.emacs"

# ubuntu aliases
# alias AddRepo="sudo add-apt-repository -y"
# alias RemoveRepo="sudo add-apt-repository --remove"
# alias Install="sudo apt-get install -y"
# alias Remove="sudo apt-get remove"
# alias RemoveAll="sudo apt-get remove --purge"
# alias Autoremove="sudo apt-get autoremove"
# alias Update="sudo apt-get update -y"
# alias Upgrade="sudo apt-get upgrade -y"
# utilidades
alias Notify="notify-send 'Comando terminado' 'El comando introducido ha terminado de realizarse.'"
alias :q="exit"
# server aliases
# alias ServerUp="sudo /opt/lampp/lampp start"
# alias ServerDown="sudo /opt/lampp/lampp stop"
alias pacman="sudo pacman"

# por si hay problemas con las librerias de steam
alias SteamArreglar='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete'
# alias fuck="$(thefuck $(fc -ln -1))"

# actualizar enlaces simbolicos
alias restow="cd ~/Documentos/MEGAsync/Documentos/Stow && stow -v -R -t ~/ private public --ignore='.git'"

bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

export ANDROID_HOME=/opt/android-sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

## Taskawarrior
alias in="task add +in"
export PS1='$(task +in +PENDING count) '$PS1

tickle () {
    deadline=$1
    shift
    in +tickle wait:$deadline $@
}
alias tick=tickle
alias think='tickle +1d'

webpage_title (){
    wget -qO- "$*" | hxselect -s '\n' -c  'title' 2>/dev/null
}

read_and_review (){
    link="$1"
    shift
    title=$(webpage_title $link)
    echo $title
    descr="Read and review: $title"
    id=$(task add +rnr +pc "$descr" "$@" | sed -n 's/Created task \(.*\)./\1/p')
    task "$id" annotate "$link"
}

alias rnr=read_and_review

process_task () {
    id="$1"
    shift
    task "$id" modify -in "$@"
}

alias prc=process_task
