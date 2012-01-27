# turn on autocompletion

#------------------------------------------
# Options
#------------------------------------------
# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_DUPS

# Alt+S to insert sudo at beginning of line
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo


zmodload zsh/complist
autoload -U compinit && compinit
autoload -U zmv         # mv on stereoids

#------------------------------------------
# Autocompletion
#------------------------------------------
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*' menu select

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' verbose yes

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# colorizer auto-completion for kill
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
# foo
#------------------------------------------
# Colors
#------------------------------------------
# set colors to make terminal pretty!
autoload colors; colors
export CLICOLOR=1

export LS_OPTIONS='--color=auto'
export LSCOLORS=Exfxcxdxbxegedabagacad

PROMPT="%{$fg[red]%}[%n@%m] % ~%{$reset_color%} "
RPROMPT="[%{$fg[white]%}%3c%{$reset_color%}][%{$fg[red]%}%?%{$reset_color%}]" # prompt for right side of screen

#------------------------------------------
# Key Bindings
#------------------------------------------
bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char

setopt no_list_beep

# directory in titlebar
chpwd() {
  [[ -t 1 ]] || return
  case $TERM in
    sun-cmd) print -Pn "\e]l%~\e\\"
      ;;
    *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
      ;;
  esac
}

# call chpwd when first loaded
chpwd

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.txz)       tar Jxvf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}



### 	  PATH		###
export PATH=/usr/local/bin:$PATH
# 
#
# For some reason shell was still /bin/bash
# Even using chsh doesn't fix this :S
export SHELL="/bin/zsh"


 #	ALIASES 	###

alias vi='vim'
alias ls='ls -l'
alias la='ls -la'
alias psx="ps aux | grep -i" 
alias reload="source ~/.zshrc"

# Play safe!
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# Typos
alias cd..="cd .."
alias dl="curl -L -O"

# My Aliases
alias runmongo="mongod --dbpath Development/mongodb"
alias organise="mate ~/Personal/life.md"
alias quotes="mate ~/Personal/quotes.md"

alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

# SSH Alias
alias doc="ssh jzk09@shell3.doc.ic.ac.uk"


[[ -s "/Users/jamal/.rvm/scripts/rvm" ]] && source "/Users/jamal/.rvm/scripts/rvm"
