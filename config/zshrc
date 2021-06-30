########## Aliases ##########

alias ls='ls --color=always'     # GNU ls
alias la='ls --color=always -a'  # GNU ls -a
alias ll='ls --color=always -la' # GNU ls -la

alias e='emacsclient -c'

alias pipes='pipes.sh'       # Pipes screensaver

alias rm='trash' # Send to trash instead of deleting

alias ta='tmux attach -t'      # Tmux attach to session
alias tn='tmux new-session -s' # Tmux create session
alias tl='tmux list-sessions'  # Tmux list sessions

alias vtop='vtop -t nord' # Vtop system monitor

alias mutt='neomutt' # Terminal email client
alias please='sudo'  # For a nicer terminal experience

alias vim='nvim' # Open Neovim
alias vi='nvim'  # Open Neovim
alias v='nvim'   # Open Neovim

alias nix-help="manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix"

alias e='emacsclient -c'

########## Completion ##########

bindkey '^[[A' up-line-or-search    # Search up through history
bindkey '^[[B' down-line-or-search  # Search down through history

zstyle ':completion:*' menu yes select                      # Tab menu
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case insensitive matching

autoload -Uz compinit && compinit # Initialize completion
zmodload -i zsh/complist          # Initialize completion

export LSCOLORS='gxbxaxaxCxcxcxcxcxgxgx'                                               # ls command colors for BSD
export LS_COLORS='di=36:ln=31:so=30:pi=30:ex=1;32:bd=32:cd=32:su=32:sg=32:tw=36:ow=36' # ls command colors for Linux

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # ls colors for completion

########## Options ##########

setopt AUTO_CD              # If command can't be executed, and is name of directory, cd to that directory
setopt AUTO_PUSHD           # Go to previous directories with cd
setopt HIST_IGNORE_ALL_DUPS # Ignore duplicate commands
setopt HIST_REDUCE_BLANKS   # Remove blanks from commands
setopt PROMPT_SUBST         # Prompt substitution
setopt PUSHD_IGNORE_DUPS    # Ignore duplicates
setopt PUSHD_SILENT         # Silent pushing and popping
setopt SHARE_HISTORY        # Share history between sessions

export EDITOR='emacsclient -c'  # Set default editor
export VISUAL='emacsclient -c'  # Set default editor
export BAT_THEME="TwoDark"      # Set bat theme
export TERM=xterm-256color      # Set term variable
export FPATH="/usr/local/share/zsh/functions:$FPATH"
export QT_QPA_PLATFORMTHEME=qt5ct
export XDG_CONFIG_HOME=~/.config

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/usr/local/opt/llvm/bin/lldb:$PATH"                # Debugger
    export PATH="/usr/local/sbin:$PATH"                             # Add sbin to path
    export PATH="/Applications/calibre.app/Contents/MacOS/:$PATH"   # Add Calibre command line tools to path
    export PATH="/Applications/qutebrowser.app/Contents/MacOS/:$PATH"   # Add Calibre command line tools to path
fi

export PATH="$HOME/.bin/:$PATH"   # Add user binaries and scripts to path

########## Prompt ##########

export PS1="%F{blue}%~%f %(?.%F{green} %f.%F{red} %f) " # Alternatives for prompt icon: ◯, •, ❯, ∮, λ, Δ, 

########## ZLE ##########

autoload -U edit-command-line && zle -N edit-command-line # Load edit current command

zle -N fzf-history

bindkey '^@' edit-command-line  # Bind edit current command
bindkey "^[[1;3C" forward-word  # Bind forward one word
bindkey "^[[1;3D" backward-word # Bind backward one word
bindkey '^A' beginning-of-line  # Bind beginning of line
bindkey '^E' end-of-line        # Bind end of line
bindkey '^H' backward-kill-word # Bind delete word backwards
bindkey '^L' clear-screen       # Bind clear screen
bindkey '^U' backward-kill-line # Bind delete line

function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
