# make alt + left/right arrow work in tmux in kitty
WORDCHARS='*?_~&;!#$%^(){}[]<>' # add "-" "_" "." if you want to treat them as part of a word
bindkey -e
# iterm
# bindkey "\e\e[D" backward-word # ⌥←
# bindkey "\e\e[C" forward-word # ⌥→

# kitty
bindkey "\e[1;3D" backward-word # ⌥←
bindkey "\e[1;3C" forward-word  # ⌥→
#
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Disable annoying bell
export BASH_SILENCE_DEPRECATION_WARNING=1

# Ubuntu style colorful prompt
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# source api keys
source ~/.api_keys

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
    . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
  else
    export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
  fi
fi
unset __conda_setup

# <<< conda initialize <<<

# pnpm
export PNPM_HOME="/Users/chao/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# for zoxide
eval "$(zoxide init zsh)"

# for fzf
eval "$(fzf --zsh)"

# zsh-autosuggestions & syntaxhighlighting
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# key bindings for autocomplet, cycle through suggestions
bindkey '^I' menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete

# personal aliases
alias pinyc='ssh -i ~/.ssh/raspi_ssh pi@192.168.1.111'
alias sshnyc='ssh -i ~/.ssh/raspi_ssh pi@10.0.0.111'
alias pichi='ssh -i ~/.ssh/chicago_pi pi@192.168.1.228'
alias imac='ssh -i ~/.ssh/imac_chao Chao@192.168.1.112'
# for using with kitty
alias vim=nvim
alias clr='clear' # since ctrl-l is not working in tmux
# alias ls='ls --color=auto'
alias ll='lsd -lah'
alias l='lsd -lah'
alias ls='lsd'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'

# starship
eval "$(starship init zsh)"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/opt/homebrew/Caskroom/miniconda/base/condabin/mamba';
export MAMBA_ROOT_PREFIX='/opt/homebrew/Caskroom/miniconda/base';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
