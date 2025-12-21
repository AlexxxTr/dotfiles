# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Aliases
if ls --color=auto &>/dev/null; then
	alias ls='ls -p --color=auto'
else
	alias ls='ls -p -G'
fi

alias grep='grep --color=auto'
alias vim='nvim'
alias v='nvim'
alias c='clear'
alias yarn="corepack yarn"
alias yarnpkg="corepack yarnpkg"
alias pnpm="corepack pnpm"
alias pnpx="corepack pnpx"
alias npm="corepack npm"
alias npx="corepack npx"

# General env variables
export HISTCONTROL='ignoredups'
export HISTSIZE=5000
export HISTFILESIZE=5000
export LSCOLORS='ExGxbEaECxxEhEhBaDaCaD'
export PAGER='less'

# Shell options
shopt -s cdspell
shopt -s checkwinsize
shopt -s extglob

# Bash Version >= 4
shopt -s autocd   2>/dev/null || true
shopt -s dirspell 2>/dev/null || true

# Add some custom things script to my path
export PATH="$PATH":"$HOME/.local/scripts/"

# Custom programs to add
[[ -x "$(command -v fnm)" ]] && eval "$(fnm env --use-on-cd --shell bash)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
[[ -x "$(command -v pyenv)" ]] && eval "$(pyenv init -)"

[[ -x "$(command -v fzf)" ]] && eval "$(fzf --bash)"

# bind control-f to tmux-sessionizer if tmux-sessionizer exists
[[ -x "$(command -v tmux-sessionizer)" ]] && bind -x '"\C-f": tmux-sessionizer'

# Adjust the prompt

_prompt_command() {
        local user=$USER
        local host=${HOSTNAME%%.*}
        local pwd=${PWD/#$HOME/\~}
        local ssh=
        [[ -n $SSH_CLIENT ]] && ssh='[ssh] '
        printf "\033]0;%s%s@%s:%s\007" "$ssh" "$user" "$host" "$pwd"
}
PROMPT_COMMAND=_prompt_command
PROMPT_DIRTRIM=6

make_prompt() {
    local esc='\e[0m'
    local bold='\e[1m'
    local col1='\e[38;5;24m'
    local col2='\e[38;5;54m'
    local col3='\e[38;5;114m'
    local col4='\e[38;5;84m'

    # username
    PS1='\['$col1'\]\u\['$esc'\]'

    # @
    PS1+='\['$bold'\]\['$col2'\]@\['$esc'\]'

    # hostname
    PS1+='\['$col3'\]\h\['$esc'\] '
    
    # Optionally try to add git brach
    PS1+='$(branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); [[ -n $branch ]] && echo "\[\e[1m\](\[\e[38;5;124m\]git:$branch\[\e[0m\]) ")'

    # prompt char
    PS1+='\['$col4'\]\$\['$esc'\] '
}

make_prompt

# source other files
. ~/.bash_git_aliases || true
