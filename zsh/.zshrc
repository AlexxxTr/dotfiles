if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit snippet OMZT::robbyrussell

setopt promptsubst

zinit wait lucid for \
        OMZL::git.zsh \
  atload"unalias grv" \
        OMZP::git

zinit as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh" for \
        direnv/direnv

zstyle ':omz:alpha:lib:git' async-prompt no

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey '^R' history-incremental-search-backward

# Aliases
alias vim='nvim'
alias v='nvim'
alias c='clear'
alias yarn="corepack yarn"
alias yarnpkg="corepack yarnpkg"
alias pnpm="corepack pnpm"
alias pnpx="corepack pnpx"
alias npm="corepack npm"
alias npx="corepack npx"

# Python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Enable fzf keybindings
eval "$(fzf --zsh)"

if [ -d "$HOME/.deno/env" ]; then
    . "$HOME/.deno/env"
fi

eval "$(fnm env --use-on-cd --shell zsh)"

# Tmux sessionizer script 
PATH="$PATH":"$HOME/.local/scripts/"
bindkey -s ^f "tmux-sessionizer.sh\n"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# manual neovim install
export PATH=$PATH:/opt/nvim-linux64/bin
export PATH=$PATH:$HOME/.local/bin

export EDITOR='nvim'

bindkey -e
