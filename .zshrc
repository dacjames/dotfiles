# Path to your oh-my-zsh installation.
export ZSH=/Users/dcollins/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

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
plugins=(git osx)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

POWERLINE_SOURCE="$HOME/Code/powerline/powerline"
POWERLINE_VENV="$HOME/.venv/powerline"
POWERLINE_PIP="$POWERLINE_VENV/bin/pip"
POWERLINE_PYTHON="$POWERLINE_VENV/bin/python"

## If powerline breaks b/c of python updates:
##   - Recreate ~/.venv/powerline
##   - Reinstall powerline: pip -e ~/Code/powerline/powerline/
##   - Restart powerline-daemon: powerline-daemon --replace

if ! "$POWERLINE_VENV/bin/python" --version >/dev/null 2>&1; then
    echo "powerline venv corrupted, reinstalling:"
    if [ -d "$POWERLINE_VENV.bckp" ]; then
        rm -r "$POWERLINE_VENV.bckp"
    fi
    mv "$POWERLINE_VENV" "$POWERLINE_VENV.bckp"
    virtualenv "$POWERLINE_VENV"
    "$POWERLINE_PIP" install -e "$POWERLINE_SOURCE"
    "$POWERLINE_PYTHON" "$POWERLINE_SOURCE/scripts/powerline-daemon" --replace
fi

if ! "$POWERLINE_VENV/bin/python" -c 'import powerline_gitstatus' >/dev/null 2>&1; then
  echo "installing powerline-gitstatus"
  "$POWERLINE_PIP" install powerline-gitstatus
fi

## Powerline ##
# Start the background daemon
"$POWERLINE_PYTHON" "$POWERLINE_SOURCE/scripts/powerline-daemon" -q
# Enable the powerline prompt
source "$POWERLINE_SOURCE/powerline/bindings/zsh/powerline.zsh"


## Docker ##
# Arch VM must be running for docker commands to work
# alias docker='docker -H tcp://vm:5555'

alias gu='git add -u'
alias gA='git add -A'
alias gs='git status'
alias gm='git commit -m'
alias gf='git flow'
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
if [ ! -d "$HOME/.dotfiles" ]; then
  git init --bare "$HOME/.dotfiles"
  dotfiles config --local status.showUntrackedFiles no
  dotfiles config --local status.relativePaths no
fi

# Adobe Font Developer Kit
if [ -d "/usr/local/FDK" ]; then
  export FDK_PATH="/usr/local/FDK/Tools/osx"
  export PATH="$FDK_PATH:$PATH"
fi
