# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme agnoster

set -x TERM xterm-256color
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias fishconfig="vim ~/.config/fish/config.fish"
# ubuntu aliases
# alias AddRepo="sudo add-apt-repository -y"
# alias RemoveRepo="sudo add-apt-repository --remove"
# alias Install="sudo apt-get install -y"
# alias Remove="sudo apt-get remove"
# alias RemoveAll="sudo apt-get remove --purge"
# alias Autoremove="sudo apt-get autoremove"
# alias Update="sudo apt-get update -y"
# alias Upgrade="sudo apt-get upgrade -y"
alias Notify="notify-send 'Comando terminado' 'El comando introducido ha terminado de realizarse.'"
alias :q="exit"
# server aliases
# alias ServerUp="sudo /opt/lampp/lampp start"
# alias ServerDown="sudo /opt/lampp/lampp stop"
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
alias pacman="sudo pacman"
# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish
