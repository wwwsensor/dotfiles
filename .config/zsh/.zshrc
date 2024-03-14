# WWW    : https://github.com/wwwsensor/dotfiles
# Author : @sensor @ss

## ALIASES & OTHER ############
alias a=alias
# Suffix
for s in gitconfig gitignore txt conf yml toml log json ini zsh lua py md mod html typ
do; a -s $s=$EDITOR; done
a -s pdf="ds zathura"
# Other
a ddgr="ddgr --noua --rev --url-handler=xdg-open"
a zshrc="$EDITOR $ZDOTDIR/.zshrc"
a pas="wl-paste"
a cop="wl-copy"
a fp="flatpak"
a cs="cht.sh"
a trn="trans"
a man="man "
a m="tldr "
# Git
a g="git"
a lg="lazygit"
a gx="grep '=\"g' $ZDOTDIR/.zshrc | sed -e 's/a //g'"
a gg="g commit -m 'Update' && g push"
a grm="g rm --cached"
a gco="g commit"
a gr="g restore"
a gre="g reset"
a gcl="g clone"
a gs="g status"
a gpu="g push"
a gd="g diff"
a ga="g add"
# ls
a l="lsd --size short --date +'%d/%m/%y %H:%m'" &&
a la="l -A" &&
a ll="l -l" &&
a lla="ll -A"
# FS
## Write
a de="sudoedit"
a mkd="mkdir"
a rr="rm -rf"
a d="doas "
## Read
a e="$EDITOR"
a i="swayimg"
a c="bat"
unalias a
N=/dev/null
##############################

## FUNCTIONS #################
zstats(){ fc -l 1 | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' | grep -v "./" | sort -nr | head -n 20 | column -c3 -s " " -t | nl; }
mkcd(){ mkdir -p $@ && cd ${@:$#}; }
take(){
	if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]; then
	  data="$(mktemp)" 
	  curl -L "$1" > "$data"; tar xf "$data"
	  dir="$(tar tf "$data" | head -n 1)" 
	  rm "$data"; cd "$dir"
	elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
		git clone "$1" &&	cd "$(basename ${1%%.git})"
	else
		mkcd "$@"
	fi
}
pd(){ cd ..;zle reset-prompt; }
ds(){ $@ & disown; }
##############################

## ZSH #######################
# $ man zshall for info
HISTFILE=$HOME/.cache/zshist && SAVEHIST=1000 && HISTSIZE=$SAVEHIST
setopt inc_append_history hist_ignore_all_dups hist_reduce_blanks autocd globdots
zstyle ":completion:*" ignored-patterns "init"
zstyle ":completion:*" menu yes select 
autoload -Uz colors compinit && { compinit -u -d ~/.cache/.zcompdump; colors; } # sh
zmodload zsh/complist # c
##############################

## PROMPT ####################
PS1="%U%3~%u "; RPS1="%(?..%F{red}%?%f)"
##############################

## BINDS #####################
# Readline modes:
#   vicmd = normal
#   viins = insert
#   visual = visual
#   menuselect
#   main
#   etc...
#
# See current binds of a mode:
# $ bindkey -M <mode>
#
# Viins is the default mode
# while vi mode is enabled.

# Enable vi mode
bindkey -v
# Menuselect
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
# Viins
bindkey -v "^?" backward-delete-char # strange bug
bindkey "^[[Z" pd && zle -N pd
bindkey "^K"   history-substring-search-up
bindkey "^J"   history-substring-search-down
for pattern in jk jK Jk JK
do; bindkey "$pattern" vi-cmd-mode; done
# Vicmd
bindkey -M vicmd "L" end-of-line
bindkey -M vicmd "H" beginning-of-line
bindkey -M vicmd "^[[Z" pd && zle -N pd
bindkey -M vicmd "^K"   history-substring-search-up
bindkey -M vicmd "^J"   history-substring-search-down
##############################

## VI MODE ###################
zle-keymap-select(){
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = "block" ]]; then
    echo -ne "\e[1 q"
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = "" ]] || [[ $1 = "beam" ]]; then
    echo -ne "\e[5 q"
  fi
} && zle -N zle-keymap-select
precmd(){ echo -ne "\e[5 q"; }
##############################

## PLUGINS ###################
for p in zsh-history-substring-search zsh-syntax-highlighting
do; . /usr/share/zsh/plugins/$p/$p.zsh 2>/dev/null; done
##############################

cal -m
