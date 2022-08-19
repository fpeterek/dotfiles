# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export EDITOR=nvim
export VISUAL=nvim

setopt correct
setopt numericglobsort
setopt nobeep
setopt appendhistory
setopt autocd

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
# I may wish to enable the following two options in the future
# setopt INC_APPEND_HISTORY
# setopt SHARE_HISTORY

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={a-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500

alias cp='cp -i'
alias df='df -h'
alias free='free -m'
alias ls='lsd'
alias la='ls -A'
alias ll='ls -la'
alias cat='bat'
alias vimrc='vim ~/.vimrc'

autoload -U compinit colors zcalc
compinit -d
colors

setopt prompt_subst

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey -e
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# One of the following keybindings is bound to work someday
# Unfortunately, substring search stopped working for no apparent reason
# I had to try multiple keybindings until one keybinding worked
# Let's hope the following bindings will work for me on other devices and
# terminal emulators as well

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

bindkey '\eOA' history-substring-search-up
bindkey '\eOB' history-substring-search-down

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

cowfortune() {
    fortune | cowsay -f $(ls /usr/share/cows | shuf -n1) | lolcat
}

cowfortune

reorder-screens() {
    xrandr --output HDMI-0 --auto --output HDMI-1 --left-of HDMI-0
}

# export JAVA_HOME='/usr/lib/jvm/java-11-openjdk'
# export JAVA_HOME='/usr/lib/jvm/java-17-openjdk'
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'

# export SPARK_HOME='/home/fpeterek/spark'
# export PYSPARK_PYTHON=python3
# export PATH=$SPARK_HOME/bin:$PATH

export BAT_THEME='OneHalfDark'

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

