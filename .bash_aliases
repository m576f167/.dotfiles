# Disable Ctrl-s
stty -ixon

## Set Vim as default editor
export EDITOR='vim'
export VISUAL='vim'

# Oh my git
source ~/.oh-my-git/prompt.sh

# Make sure python is installed with dynamic library in pyenv
export PYTHON_CONFIGURE_OPTS="--enable-framework"

# Load pyenv if exist
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Load rbenv if exist
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Set bat config file path
export BAT_CONFIG_PATH="~/.config/bat/config"

# Function to install my dependencies
function install_my_dependency() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Installing dependencies for Linux"
    sudo apt-get install -y python3-venv
    sudo apt-get install -y rbenv
    sudo apt-get install -y nodejs
    sudo apt-get install -y golang
    sudo apt-get install -y htop
    sudo apt-get install -y iftop
    sudo snap install gotop
    sudo apt-get install -y vim
    sudo apt-get install -y git
    sudo apt-get install -y ripgrep
    sudo apt-get install -y silversearcher-ag
    sudo add-apt-repository ppa:lazygit-team/release; sudo apt-get update; sudo apt-get install lazygit
    sudo apt-get install -y icdiff
    sudo apt-get install -y bat
    sudo apt-get install -y exuberant-ctags
    sudo apt-get install -y ranger
    sudo apt-get install -y termshark
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Installing dependencies for MacOS"
    brew install pyenv
    brew install rbenv
    brew install node
    brew install go
    brew install htop
    brew install iftop
    brew install gotop
    brew install vim
    brew install git
    brew install ripgrep
    brew install the_silver_searcher
    brew install lazygit
    brew install icdiff
    brew install bat
    brew install ctags
    brew install ranger
    brew install termshark
  fi
}

