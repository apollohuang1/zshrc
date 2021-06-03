# Initialize development environment things.
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Add for homebrew.
export PATH="/usr/local/sbin:$PATH"

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
# Need the space at the end to look pretty.
PS1="%{$fg[blue]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

# Edit this document.
alias edit_zshrc='subl ~/.zshrc'
# Open website project.
alias zweb='cd ~/Documents/Projects/zhengdongwang.com'
# Open iCloud.
alias ic='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/'

# Better terminal.
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -FGlAhp'
alias c='clear'
alias cd..='cd ..'
alias nps='ps | wc'
alias qfind='find . -name'
alias fval='valgrind -q --partial-loads-ok=yes --leak-check=yes'
alias pullgit='git pull origin main'
alias pullgitm='git pull origin master'
alias sourcezsh='source ~/.zshrc'

# Push to GitHub from any directory.
pushgit() {
  if [[ $# -eq 0 ]] ; then
    printf "No commit message!\n"
  else
    git add -A
    git commit -m "$1"
    git push origin main
  fi
}

# Update my website.
pushweb() {
  if [[ $# -eq 0 ]] ; then
    printf "No commit message!\n"
  else
    zweb
    bundle exec middleman build
    middleman s3_sync
    pushgit "$1"
  fi
  cd -
}

# Update the repository that has this file.
pushzsh() {
  if [[ $# -eq 0 ]] ; then
    printf "No commit message!\n"
  else
    cd ~/Documents/Utility/zshrc/
    cp ~/.zshrc zshrc 
    pushgit "$1"
    source ~/.zshrc
  fi
  cd -
}

printf 'Welcome to a better terminal\n'
