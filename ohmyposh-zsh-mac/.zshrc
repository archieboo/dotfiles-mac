

# make alt + left/right arrow work in tmux in kitty
# bindkey -e
# bindkey '^[[1;3C' forward-word # this is alt-left
# bindkey '^[[1;3D' backward-word # this is alt-right
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
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
bindkey              '^I'         menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete

# personal aliases
alias nygc='ssh -i ~/.ssh/nygc_pe2 cdai@pe2-login.c.nygenome.org -t "zsh -l" '
alias nslab='ssh -i ~/.ssh/nygc_pe2 cdai@slab.c.nygenome.org -t "zsh -l" '
alias umtnygc='umount -f ~/nygc_cluster ~/nygc_home_mount'
alias pinyc='ssh -i ~/.ssh/raspi_ssh pi@192.168.1.111'
alias sshnyc='ssh -i ~/.ssh/raspi_ssh pi@10.0.0.111'
alias pichi='ssh -i ~/.ssh/chicago_pi pi@192.168.1.228'
alias imac='ssh -i ~/.ssh/imac_chao Chao@192.168.1.112'
alias uc1='ssh chaodai@midway2-login1.rcc.uchicago.edu '
alias uc2='ssh chaodai@midway2-login2.rcc.uchicago.edu '
alias uc3='ssh chaodai@midway3-login3.rcc.uchicago.edu '
alias uc4='ssh chaodai@midway3-login4.rcc.uchicago.edu '
# for using with kitty
alias kuc1='kitten ssh chaodai@midway2-login1.rcc.uchicago.edu '
alias kuc2='kitten ssh chaodai@midway2-login2.rcc.uchicago.edu '
alias kuc3='kitten ssh chaodai@midway3-login3.rcc.uchicago.edu '
alias kuc4='kitten ssh chaodai@midway3-login4.rcc.uchicago.edu '
alias vim=nvim
alias clr='clear' # since ctrl-l is not working in tmux
alias ls='ls --color=auto'
alias l='ls -lah --color=auto'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias omps='oh-my-posh'



# oh-my-posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/dotfiles/ohmyposh-zsh-mac/powerlevel10k_rainbow_mod.toml)"
  # eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/powerlevel10k_lean.omp.json)"
  # eval "$(oh-my-posh init zsh)"
fi


