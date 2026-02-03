# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
plugins=(
  git
  bundler
  dotenv
  rake
  rbenv
  ruby
  npm # you added this
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-nvm
)

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
alias tmux="tmux -u"
# export BROWSER="thorium-browser"
bindkey "^H" backward-kill-word

# Created by `pipx` on 2024-07-01 03:44:33
export PATH="$PATH:/home/bhupeshr45/.local/bin"
export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
# export TERMINAL=ghostty

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


export PATH=$PATH:/home/bhupeshr45/.spicetify

# Auto Python venv activate/deactivate
# Variable to track the last activated virtual environment
_LAST_VENV=""

# Function to find and activate venv in the current or parent directories
function auto_activate_venv() {
    local dir="$PWD"
    while [ "$dir" != "/" ]; do
        if [ -f "$dir/venv/bin/activate" ]; then
            if [ "$_LAST_VENV" != "$dir/venv" ]; then
                [ -n "$_LAST_VENV" ] && deactivate 2>/dev/null
                source "$dir/venv/bin/activate"
                _LAST_VENV="$dir/venv"
            fi
            return
        elif [ -f "$dir/.venv/bin/activate" ]; then
            if [ "$_LAST_VENV" != "$dir/.venv" ]; then
                [ -n "$_LAST_VENV" ] && deactivate 2>/dev/null
                source "$dir/.venv/bin/activate"
                _LAST_VENV="$dir/.venv"
            fi
            return
        fi
        dir="$(dirname "$dir")"
    done

    # Deactivate if no venv found and one is active
    if [ -n "$_LAST_VENV" ]; then
        deactivate 2>/dev/null
        _LAST_VENV=""
    fi
}

# Trigger auto_activate_venv when changing directories
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate_venv

# Activate for the initial directory on shell startup
auto_activate_venv


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

source <(fzf --zsh)

# Vim mode
bindkey -v
export KEYTIMEOUT=1
KEYTIMEOUT=10  # Time in hundredths of a second (100 = 1s)
bindkey -M viins 'jk' vi-cmd-mode

# Function to switch to insert mode cursor style
function zle-line-init() {
  echo -ne '\e[5 q'  # Blinking beam for insert mode
}
zle -N zle-line-init

# Function to switch to normal mode cursor style
function zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne '\e[2 q'  # Blinking underline for normal mode
  else
    echo -ne '\e[5 q'  # Blinking beam for insert mode
  fi
}
zle -N zle-keymap-select

# Restore cursor on exit
function zle-line-finish() {
  echo -ne '\e[0 q'  # Reset to default
}
zle -N zle-line-finish

# Set Vulkan as the Default Graphics API
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/intel_icd.x86_64.json
export VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d

alias tmc='/home/bhupeshr45/tmc-cli-rust-x86_64-unknown-linux-gnu-v1.1.2'
export TMC_LANGS_CONFIG_DIR='/home/bhupeshr45/tmc-config'
fpath=(/home/bhupeshr45/.local/share/tmc-autocomplete/_tmc  $fpath)
compdef _tmc tmc

# pyenv setup
# echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
# echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
# echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/bhupeshr45/.bun/_bun" ] && source "/home/bhupeshr45/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Zellij tab rename
# Only run in interactive shells
# if [[ $- == *i* ]]; then
#   # Check if inside a Zellij session and `zellij` is available
#   if [[ -n "$ZELLIJ" ]] && command -v zellij >/dev/null 2>&1; then
#
#     function zellij_tab_name_update_preexec() {
#       local cmd_line=(${(z)1})
#       local process_name=$cmd_line[1]
#
#       if [[ -n "$process_name" && "$process_name" != "z" ]]; then
#         nohup zellij action rename-tab "$process_name" >/dev/null 2>&1 &
#       fi
#     }
#
#     function zellij_tab_name_update_precmd() {
#       # Check the last command run (stored in $history[$HISTCMD])
#       local last_cmd=${history[$((HISTCMD-1))]}
#       local last_cmd_name=(${(z)last_cmd}) # Tokenize
#
#       if [[ "$last_cmd_name" == "z" ]]; then
#         nohup zellij action rename-tab "$(basename "$PWD")" >/dev/null 2>&1 &
#       fi
#     }
#
#     autoload -Uz add-zsh-hook
#     add-zsh-hook preexec zellij_tab_name_update_preexec
#     add-zsh-hook precmd zellij_tab_name_update_precmd
#   fi
# fi
#

# zellij_tab_name_update() {
#     if [[ -n $ZELLIJ ]]; then
#         local current_dir=$PWD
#         if [[ $current_dir == $HOME ]]; then
#             current_dir="~"
#         else
#             current_dir=${current_dir##*/}
#         fi
#         command nohup zellij action rename-tab $current_dir >/dev/null 2>&1
#     fi
# }
# zellij_tab_name_update
# chpwd_functions+=(zellij_tab_name_update)

autoload -Uz add-zsh-hook

function set_zellij_title() {
    command zellij action rename-tab "$1" >/dev/null 2>&1
}

function set_tab_to_working_dir() {
    # Use native Zsh expansion for current folder name
    set_zellij_title ${(%):-%1~}
}

function set_tab_to_command_line() {
    local cmd=$1
    # Get the first word of the command (the program name)
    local prog=${cmd%% *}

    # List of commands to IGNORE (keep the directory name instead)
    local -a ignore_list=(ls cd clear ll la exit zellij)

    # If the command is NOT in the ignore list, rename the tab
    if [[ ${ignore_list[(I)$prog]} -eq 0 ]]; then
        set_zellij_title "$cmd"
    fi
}

if [[ -n $ZELLIJ ]]; then
    add-zsh-hook precmd set_tab_to_working_dir
    add-zsh-hook preexec set_tab_to_command_line
fi

export PATH="$HOME/.cargo/bin:$PATH"

# Enable Vulkan Video support in vulkan-intel
export ANV_DEBUG=video-decode,video-encode

export TERMINAL=kitty

export PATH=$PATH:$(go env GOPATH)/bin

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias tmux-sessionizer='~/GithubClones/tmux-sessionizer/tmux-sessionizer'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

eval "$(zoxide init zsh)"
