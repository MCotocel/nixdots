{
  home.file.".zshrc".text = ''
    ######### Completion ##########

    bindkey '^[[A' up-line-or-search    # Search up through history
    bindkey '^[[B' down-line-or-search  # Search down through history

    zstyle ':completion:*' menu yes select                      # Tab menu
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case insensitive matching

    autoload -Uz compinit && compinit # Initialize completion
    zmodload -i zsh/complist          # Initialize completion

    export LS_COLORS='di=36:ln=31:so=30:pi=30:ex=1;32:bd=32:cd=32:su=32:sg=32:tw=36:ow=36' # ls command colors for Linux

    zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS} # ls colors for completion

    ########### Options ##########

    setopt AUTO_CD              # If command can't be executed, and is name of directory, cd to that directory
    setopt AUTO_PUSHD           # Go to previous directories with cd
    setopt HIST_IGNORE_ALL_DUPS # Ignore duplicate commands
    setopt HIST_REDUCE_BLANKS   # Remove blanks from commands
    setopt PROMPT_SUBST         # Prompt substitution
    setopt PUSHD_IGNORE_DUPS    # Ignore duplicates
    setopt PUSHD_SILENT         # Silent pushing and popping
    setopt SHARE_HISTORY        # Share history between sessions

    export EDITOR='emacsclient -c --alternate-editor=nvim' # Set default editor
    export VISUAL='emacsclient -c --alternate-editor=nvim' # Set default editor
    export BAT_THEME="base16" # Set bat theme
    export TERM=xterm-256color # Set term variable
    export QT_QPA_PLATFORMTHEME=qt5ct
    export XDG_CONFIG_HOME=~/.config
    export PATH="$HOME/.bin/:$PATH"   # Add user binaries and scripts to path

    HISTFILE=~/.zsh_history
    HISTSIZE=1000
    SAVEHIST=1000

    ########## Prompt ##########

    export PS1="%F{blue}%~%f " # Alternatives for prompt icon: ◯, •, ❯, ∮, λ, Δ, 

    ########## ZLE ##########

    autoload -U edit-command-line && zle -N edit-command-line # Load edit current command
    
    bindkey '^A' beginning-of-line  # Bind beginning of line
    bindkey '^E' end-of-line        # Bind end of line
    bindkey '^L' clear-screen       # Bind clear screen
    bindkey '^U' backward-kill-line # Bind delete line

    export LESS_TERMCAP_mb=$'\e[1;32m'
    export LESS_TERMCAP_md=$'\e[1;32m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;4;31m'
  '';
}
