# if [ -n "$DESKTOP_SESSION" ]; then
#     eval $(gnome-keyring-daemon --start)
#     export SSH_AUTH_SOCK
# fi

#screenfetch
fastfetch
# eval "$(starship init zsh)"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export DOTFILES_DIR="$HOME/.dotfiles"
export PATH="${PATH}:${HOME}/.local/share/JetBrains/Toolbox/scripts"
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="${PATH}:${HOME}/.config/bin/"

# Personal paths
export PATH="${PATH}:$DOTFILES_DIR/.config/bin"

function source_if_exists() { [ -f "$1" ] && source "$1" }

source_if_exists "$DOTFILES_DIR/zsh/options.zsh"
source_if_exists "$DOTFILES_DIR/zsh/git.zsh"
source_if_exists "$DOTFILES_DIR/zsh/aliases.zsh"

export DENO_INSTALL="/home/franck/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.config/bin/i3-backlight:$PATH"

alias strom="/home/franck/.local/share/JetBrains/Toolbox/scripts"
# alias docker=podman
# alias pdc="podman-compose -f docker-compose.local.yml"
alias pdc="docker compose -f docker-compose.local.yml"
alias pdl="pdc logs -f --tail 100 $1"
alias pdrl="pdc restart $1 && pdc logs -f --tail 100 $1"
alias dps="docker ps"
alias cl=clear
alias vim=nvim
alias v=nvim
alias nv=lvim
alias dswp='find . -type f -name "*.sw[klmnop]" -delete'
alias gpm="git-prune-merged"
alias grm='gpm; git-rebase-all'
alias ggm='git-get-merged'
alias grom="git rebase --interactive --autosquash master"
alias pssl="local-ssl-proxy --source 8080 --target 80 --cert $HOME/portail-certs/localhost.pem --key $HOME/portail-certs/localhost-key.pem"

alias hdmi="xrandr --addmode HDMI-1-0 -s 2560x1440"
zmodload zsh/parameter  # Needed to access jobstates variable for STARSHIP_JOBS_COUNT
alias pssl="local-ssl-proxy --source 8080 --target 80 --cert $HOME/portail-certs/localhost.pem --key $HOME/portail-certs/localhost-key.pem"

export NVM_DIR="$HOME/.nvm"
 [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
 [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#source /usr/share/nvm/init-nvm.sh

# eval export PATH="/run/user/1000/fnm_multishells/123254_1741794767792/bin":$PATH
# export FNM_MULTISHELL_PATH="/run/user/1000/fnm_multishells/123254_1741794767792"
# export FNM_VERSION_FILE_STRATEGY="local"
# export FNM_DIR="/home/franck/.local/share/fnm"
# export FNM_LOGLEVEL="info"
# export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
# export FNM_COREPACK_ENABLED="false"
# export FNM_RESOLVE_ENGINES="true"
# export FNM_ARCH="x64"
# autoload -U add-zsh-hook
# _fnm_autoload_hook () {
#     if [[ -f .node-version || -f .nvmrc || -f package.json ]]; then
#     fnm use --silent-if-unchanged
# fi
#
# }
#
# add-zsh-hook chpwd _fnm_autoload_hook \
#     && _fnm_autoload_hook
#
# rehash
alias pssl="local-ssl-proxy --source 8080 --target 80 --cert $HOME/portail-certs/localhost.pem --key $HOME/portail-certs/localhost-key.pem"
