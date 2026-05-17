#  +-----------------------------------+
#  |                                   |
#  |        System-Wide Settings       |
#  |                                   |
#  +-----------------------------------+

. /etc/profile


#  +-----------------------------------+
#  |                                   |
#  |          Default Programs         |
#  |                                   |
#  +-----------------------------------+

export EDITOR=nvim
export VISUAL=nvim


#  +-----------------------------------+
#  |                                   |
#  |            ZSH Settings           |
#  |                                   |
#  +-----------------------------------+

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

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={a-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu select

autoload -U compinit colors zcalc
compinit -d
colors

setopt prompt_subst


#  +-----------------------------------+
#  |                                   |
#  |              Plugins              |
#  |                                   |
#  +-----------------------------------+

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -e
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

bindkey "^[[3~" delete-char

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'


#  +-----------------------------------+
#  |                                   |
#  |              Aliases              |
#  |                                   |
#  +-----------------------------------+

alias cp='cp -i'
alias ls='lsd'
alias cat='bat'

alias nv='nvim'
alias nvconf='nvim ~/.config/nvim/'


#  +-----------------------------------+
#  |                                   |
#  |             Functions             |
#  |                                   |
#  +-----------------------------------+

weather() {
    LOCATION="osr"

    if [[ $1 != "" ]]
    then
        LOCATION=$1
    fi

    curl --connect-timeout 0.1 --max-time 0.2 "wttr.in/$LOCATION?0" 2> /dev/null
}

cowcat() {
    cowsay -r -C -n | lolcat
}

reorder-screens() {
    xrandr --output HDMI-0 --auto --output HDMI-1 --left-of HDMI-0
}

set-wallpaper() {
    find "~/Wallpapers" -type f | shuf -n 1 | xargs feh --bg-fill --no-fehbg
}


#  +-----------------------------------+
#  |                                   |
#  |   Environment Specific Settings   |
#  |                                   |
#  +-----------------------------------+

export JAVA_HOME='/usr/lib/jvm/java-17-openjdk'
# export JAVA_HOME='/usr/lib/jvm/java-11-openjdk'
# export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'

# export SPARK_HOME='/home/fpeterek/spark'
# export PYSPARK_PYTHON=python3


#  +-----------------------------------+
#  |                                   |
#  |                PATH               |
#  |                                   |
#  +-----------------------------------+

export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

# export PATH=$SPARK_HOME/bin:$PATH


#  +-----------------------------------+
#  |                                   |
#  |     Program Specific Settings     |
#  |                                   |
#  +-----------------------------------+

export BAT_THEME='OneHalfDark'

export AWS_VAULT_BACKEND=file


#  +-----------------------------------+
#  |                                   |
#  |             On Launch             |
#  |                                   |
#  +-----------------------------------+

fortune | cowcat
echo ""
weather | lolcat


#  +-----------------------------------+
#  |                                   |
#  |               Prompt              |
#  |                                   |
#  +-----------------------------------+

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

