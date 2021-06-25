# Homebrew.
export PATH="/usr/local/sbin:$PATH"

# pyenv.
eval "$(pyenv init -)"

# Load RVM into a shell session *as a function*.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Add RVM to PATH for scripting. Make sure this is the last PATH change.
export PATH="$PATH:$HOME/.rvm/bin"

# Share history between all sessions.
setopt SHARE_HISTORY
# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Only remember unique history.
setopt HIST_IGNORE_DUPS
# Be able to search history.
bindkey -v
bindkey "^r" history-incremental-pattern-search-backward

# Colors.
autoload -U colors && colors
PS1="%{$fg[blue]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -FGlAhp'
alias c='clear'
alias cd..='cd ..'
alias nps='ps | wc'
alias qfind='find . -name'
alias ppg='git pull origin main'
alias rc='subl ~/.zshrc'
alias web='cd ~/Documents/Utility/zhengdongwang.com'
alias ic='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/'

# Push to GitHub.
pg() {
  if [[ $# -eq 0 ]] ; then
    printf "No commit message!\n"
  else
    git add -A
    git commit -m "$1"
    git push origin main
  fi
}

# Update website.
pw() {
  if [[ $# -eq 0 ]] ; then
    printf "No commit message!\n"
  else
    web
    jekyll build
    pg "$1"
  fi
  cd -
}

# Update zshrc repository.
prc() {
  if [[ $# -eq 0 ]] ; then
    printf "No commit message!\n"
  else
    cd ~/Documents/Utility/zshrc/
    cp ~/.zshrc zshrc 
    pg "$1"
    source ~/.zshrc
  fi
  cd -
}

printf 'Welcome to a better terminal\n'
