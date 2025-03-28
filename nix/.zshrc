# ***************************** History control *******************************

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
HISTSIZE=10000
SAVEHIST=9000

HISTORY_IGNORE='(cd ..|exit|ls|nvim|ll|clear)'

# ********************************* Aliases ***********************************

alias ecfg='nvim ~/.zshrc'
alias todo='nvim ~/todo.md'
alias git-delete-merged='git branch --merged origin/main | grep -v "^\*\\|main" | xargs -n 1 git branch -D'
alias notes='cd ~/notes && nvim'

alias ll='ls -lah'

# **************************** VIM mode terminal ******************************

bindkey -v
bindkey ^R history-incremental-search-backward 
bindkey ^S history-incremental-search-forward

export KEYTIMEOUT=1

# source - probably this https://www.reddit.com/r/vim/comments/mxhcl4/setting_cursor_indicator_for_zshvi_mode_in/

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been
    # set elsewhere)
    zle -K viins 
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# *********************************** FZF *************************************

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ***************************** CLI completions *******************************

# requires brew install bash-completion
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# When using a separate local admin account, needed the following for completion items 
# 
# sudo chown -R mpurdy:staff "$(brew --prefix)/share"
# sudo chown -R mpurdy:staff /usr/local/Cellar
#
# May also need this
#
# sudo chown -R mpurdy:staff /usr/local/Homebrew/completions/zsh/_brew
# sudo chown -R mpurdy:staff /usr/local/share/aclocal /usr/local/share/info /usr/local/share/man/man3 /usr/local/share/zsh /usr/local/share/zsh/site-functions
# sudo chmod -R g-w /usr/local/share

# ********************************* AWS CLI ***********************************

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# requires setting up AWS CLI https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
alias k='kubectl'
complete -o default -F __start_kubectl k

# * AWS statusline ***

source ~/dev/kube-ps1/kube-ps1.sh
PROMPT='$(kube_ps1)'$PROMPT
