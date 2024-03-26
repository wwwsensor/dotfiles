# WWW    : https://github.com/wwwsensor/dotfiles
# Author : @sensor @ss

## ALIASES ###################
alias a=alias
# Suffix
for S in gitconfig gitignore txt conf yml toml log json ini zsh lua py md mod html typ css
do; a -s $S=$EDITOR; done
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
a lg="lazygit"
a g="git"
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
a de="doasedit"
a e="$EDITOR"
a i="swayimg"
a mkd="mkdir"
a rr="rm -rf"
a d="doas "
a c="bat"
unalias a
##############################

## FUNCTIONS #################
ztop(){ fc -l 1 | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' | grep -v "./" | sort -nr | head -n 20 | column -c3 -s " " -t | nl; }
mkcd(){ mkdir -p $@ && cd ${@:$#}; }
pd(){ cd ..;zle reset-prompt; }
ds(){ $@ & disown; }
##############################

## ZSH #######################
# Info: $ man zshall
HISTFILE=$HOME/.cache/zshist && SAVEHIST=1000 && HISTSIZE=$SAVEHIST
setopt inc_append_history hist_ignore_all_dups hist_reduce_blanks autocd globdots
zstyle ":completion:*" ignored-patterns "init"
zstyle ":completion:*" menu select
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
#   etc...
#
# See current binds of a mode:
# $ bindkey -M <mode>

# Enable vi mode
bindkey -v
# Viins
bindkey "^@" pd && zle -N pd
bindkey "^K" history-substring-search-up
bindkey "^J" history-substring-search-down
for PATTERN in jk jK Jk JK
do; bindkey "$PATTERN" vi-cmd-mode; done
# Vicmd
bindkey -M vicmd "j" down-line
bindkey -M vicmd "k" up-line
bindkey -M vicmd "L" end-of-line
bindkey -M vicmd "H" beginning-of-line
bindkey -M vicmd "^@" pd && zle -N pd
bindkey -M vicmd "^K" history-substring-search-up
bindkey -M vicmd "^J" history-substring-search-down
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
for P in zsh-history-substring-search zsh-syntax-highlighting
do; . /usr/share/zsh/plugins/$P/$P.zsh 2>/dev/null; done
##############################

N=/dev/null
cal -m
