# =============================================================================
# PATH
# =============================================================================

export PATH=$HOME/bin:/usr/local/bin:$PATH

# pnpm
export PNPM_HOME="/Users/chao/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# =============================================================================
# Environment
# =============================================================================

export EDITOR='nvim'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# source api keys
source ~/.api_keys

# =============================================================================
# Shell options
# =============================================================================

# setopt to avoid globbing report error when no match found
setopt null_glob

# History
HISTFILE=~/.zsh_history  # where history is saved on disk
HISTSIZE=10000            # commands kept in memory per session
SAVEHIST=10000            # commands persisted to disk
setopt HIST_IGNORE_DUPS   # skip saving a command if same as previous
setopt HIST_IGNORE_SPACE  # skip saving commands prefixed with a space
setopt SHARE_HISTORY      # share history across all open terminal windows

# =============================================================================
# Keybindings
# =============================================================================

# general
WORDCHARS='*?_~&;!#$%^(){}[]<>' # add "-" "_" "." if you want to treat them as part of a word
bindkey -e

# iterm
bindkey "\e\e[D" backward-word # ⌥←
bindkey "\e\e[C" forward-word # ⌥→

# key bindings for autocomplet, cycle through suggestions
bindkey '^I' menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete

# =============================================================================
# Plugins
# =============================================================================

# zsh-autosuggestions & syntaxhighlighting
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# =============================================================================
# Tool init
# =============================================================================

# for zoxide
eval "$(zoxide init zsh)"

# for fzf
eval "$(fzf --zsh)"

# =============================================================================
# Aliases
# =============================================================================

# personal aliases
alias pichi='ssh -i ~/.ssh/chicago_pi pi@192.168.1.228'
alias mmini='ssh -i ~/.ssh/macminim4 chao@192.168.1.102'
alias vim=nvim
alias clr='clear' # since ctrl-l is not working in tmux
alias ll='lsd -lah'
alias l='lsd -lah'
alias ls='lsd'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'

# =============================================================================
# Conda / Mamba
# =============================================================================

# >>> conda initialize >>>

# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/chao/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/chao/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/chao/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/chao/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

# <<< conda initialize <<<

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/Users/chao/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/chao/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# starship — must be last
eval "$(starship init zsh)"
