if status is-interactive
    # Commands to run in interactive sessions can go here
  set fish_cursor_default     block     blink
  set fish_cursor_insert      block     blink
  set fish_cursor_replace_one block     blink
  set fish_cursor_visual      block
end

# Setup aws-cli tab-completion
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin

set EDITOR nvim

fzf --fish | source
zoxide init fish | source
direnv hook fish | source
fnm env --use-on-cd --shell fish | source

# Prompts
starship init fish | source
