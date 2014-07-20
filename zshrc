# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="miloshadzic"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(zeus git brew gem osx zsh-vim-mode pow rbenv zsh-syntax-highlighting zsh-history-substring-search vim-dwim)


source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#eval "$(rbenv init -)"
export EDITOR='vim -f'
export CC="/usr/bin/gcc-4.2"
# for binstubs/bundler/rbenv
#export PATH="./bin:$PATH"
#export PATH="/usr/local/bin:$PATH"
#export PATH="/usr/local/sbin:$PATH"
PS1="$PS1"'$([ -n "$TMUX"  ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
export SSL_CERT_FILE=/opt/boxen/homebrew/opt/curl-ca-bundle/share/ca-bundle.crt


[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

. /opt/boxen/homebrew/etc/profile.d/z.sh
export PATH="/usr/local/bin/gifify:$PATH"

#Bundler
alias bis="bundle install --binstubs"
alias bi="bundle install"
alias bip="bundle install --path=.bundle"
alias be="bundle exec"
#System
alias o.="open ."
alias a.="add ."
alias cl="clear"
alias cwd='pwd | pbcopy'
alias ll="ls -lahG"
alias lp="ls -p"
alias lm="ls -la | more"
alias dt="ditto"
alias ctr="ctags -R -f ./.git/tags ."
alias agrr="ag --ignore-dir log --ignore-dir tmp --ignore tags"
alias jg="jobs"
#Databases
alias psql-server-start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias psql-server-stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
#Tmux
alias tkil="tmux kill-session -t"
alias tnw="tmux new-window -n"
alias tls="tmux ls"
alias tat="tmux at -t"
#Git
alias gfo="git fetch origin"
alias gfd="git log --diff-filter=D --summary"
alias gfa="git log --diff-filter=A --summary"
alias gfm="git log --diff-filter=M --summary"
alias gfr="git log --diff-filter=R --summary"
#Gems
alias zs="zeus"
alias zsr="zeus rake"
alias slogit="~/.slogger/slogger"
[ -f /opt/boxen/env.sh  ] && source /opt/boxen/env.sh
#Chruby
source /opt/boxen/chruby/share/chruby/chruby.sh
source /opt/boxen/chruby/share/chruby/auto.sh
RUBIES=(/opt/rubies/*)
export RUBIES

#Functions

# Helper for shell prompts and the like
current-ruby() {
  if [ -z "$RUBY_ROOT" ]; then
    echo "system"
  else
    echo "${RUBY_ROOT##*/}"
  fi
}

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
    zle redisplay
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
