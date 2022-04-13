# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export EDITOR=vim
export VISUAL=vim

setopt correct
setopt numericglobsort
setopt nobeep
setopt appendhistory
setopt autocd

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
alias la='ls -A'
alias ll='ls -la'
alias cat='bat'

autoload -U compinit colors zcalc
compinit -d
colors

setopt prompt_subst

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

fortune | cowsay -f $(ls /usr/share/cows | shuf -n1) | lolcat

# export JAVA_HOME='/usr/lib/jvm/java-14-openjdk'
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'

# export SPARK_HOME='/home/fpeterek/spark'
# export PYSPARK_PYTHON=python3
# export PATH=$SPARK_HOME/bin:$PATH

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

